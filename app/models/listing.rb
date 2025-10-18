class Listing < ApplicationRecord
  validates :body, presence: true, length: { minimum: 10, message: "must be at least 10 characters long" }

  def ai_summary
    return nil if summary.nil?
    summary.map { |k, v| "#{k}: #{v}" }.join("\n")
  end 
end
