class Listing < ApplicationRecord
  validates :body, presence: true, length: { minimum: 10, message: "must be at least 10 characters long" }
end
