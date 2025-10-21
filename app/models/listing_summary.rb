class ListingSummary < ApplicationRecord
  belongs_to :listing

  def content
    JSON.parse(metadata.dig('choices', 0, 'message', 'content'))
  end

  def model
    metadata.dig('model')
  end 

  def usage
    metadata.dig('usage')
  end

  def total_tokens
    usage.dig('total_tokens')
  end

  def prompt_tokens
    usage.dig('prompt_tokens')
  end

  def completion_tokens
    usage.dig('completion_tokens')
  end

  def ai_summary
    return nil if content.nil?
    content.map { |k, v| "#{k}: #{v}" }.join("\n")
  end 

  def day
    content&.dig('day')
  end

  def time
    content&.dig('time')
  end

  def price
    content&.dig('price')
  end

  def title
    content&.dig('title')
  end

  def location
    content&.dig('location')
  end

  def categories
    content&.dig('categories')
  end

  def description
    content&.dig('description')
  end
end
