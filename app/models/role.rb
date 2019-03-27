# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :users, dependent: :destroy
  validates :rolename, presence: true, uniqueness: { case_sensitive: false }
end
