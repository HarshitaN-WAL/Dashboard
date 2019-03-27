class Repo < ApplicationRecord
  belongs_to :project
  validates :link, presence: true, uniqueness: { case_sensitive: false }
end
