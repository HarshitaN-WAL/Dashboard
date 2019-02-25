class Project < ApplicationRecord
	has_many :project_users, dependent: :destroy
	has_many :users, through: :project_users
	validates :name, presence: true, length: {minimum: 3, maximum: 50}
	validates :start_date, presence: true, length: {is:10}
	validates :expected_target_date, presence: true
  validates :pt_token, presence: true
  validates :project_token, presence: true
	validate :validate_end_date

	scope :not_started, -> { where('start_date > ?', Time.now.to_date) }
	# default_scope { where('start_date > ?', Time.now.to_date)  }
	scope :after_date, -> (date) { where('start_date > ?', date).last }

	# def self.not_started
	# 	where('start_date > ?', Time.now.to_date)
	# end
	def validate_end_date
		if start_date > expected_target_date
			errors.add(:expected_target_date,"should be after start date")
		end
	end
end