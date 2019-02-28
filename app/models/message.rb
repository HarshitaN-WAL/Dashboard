class Message < ApplicationRecord
  belongs_to :messageable, polymorphic: true
  validates :body, presence: true
end