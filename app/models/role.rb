class Role < ApplicationRecord
	has_many :users
	validates :rolename, presence: true, uniqueness: {case_sensitive: false}
end