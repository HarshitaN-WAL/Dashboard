# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :role
  # enum role: { admin: 0, dev: 1, tester: 2 }
  has_one_attached :avatar
  has_many :messages
  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users
  has_many :messages, as: :messageable
  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       length: { minimum: 3}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 105 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }
  validates :role_id, presence: true
  delegate :rolename, to: :role
  has_secure_password
  before_save :email_downcase

  private
  def email_downcase
    self.email = email.downcase 
  end

  def top_management?
    rolename == 'Top Management'
  end

  def admin?
    rolename == 'Admin'
  end
end
