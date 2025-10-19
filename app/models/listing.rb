class Listing < ApplicationRecord
  validates :body, presence: true, length: { minimum: 10, message: "must be at least 10 characters long" }

  def ai_summary
    return nil if summary.nil?
    summary.map { |k, v| "#{k}: #{v}" }.join("\n")
  end 

  def day
    summary&.dig('day')
  end

  def time
    summary&.dig('time')
  end

  def price
    summary&.dig('price')
  end

  def title
    summary&.dig('title')
  end

  def location
    summary&.dig('location')
  end

  def categories
    summary&.dig('categories')
  end

  def description
    summary&.dig('description')
  end
end
