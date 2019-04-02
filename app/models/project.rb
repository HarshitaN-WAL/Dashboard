# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  has_many :messages, as: :messageable
  has_many :repos, dependent: :destroy
  accepts_nested_attributes_for :repos, allow_destroy: true

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :start_date, presence: true
  validates :expected_target_date, presence: true
  validates :pt_token, presence: true
  validates :project_token, presence: true
  validates :client, presence: true
  validate :validate_end_date
  validates :repos, length: {minimum: 1, too_short: "should be present for the project"}

  scope :not_started, -> { where('start_date > ?', Time.now.to_date) }
  # default_scope { where('start_date > ?', Time.now.to_date)  }
  scope :after_date, ->(date) { where('start_date > ?', date).last }
  scope :by_user, ->(user_id) { includes(users: :role).where(users: { id: user_id}) }
  # def self.not_started
  #   where('start_date > ?', Time.now.to_date)
  # end
  def validate_end_date
    if start_date > expected_target_date
      errors.add(:expected_target_date, 'should be after start date')
    end
  end
end
