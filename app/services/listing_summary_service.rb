class ListingSummaryService
  def initialize(listing)
    @listing = listing
    @client = OpenAI::Client.new(api_key: Rails.application.credentials.dig(:openai, :api_key))
  end

  def summarize_via_openai
    response = client.chat.completions.create(
      model: "gpt-4o-mini",
      messages: [
        { role: "system", content: system_prompt },
        { role: "user", content: listing.body }
      ],
      response_format: { type: "json_object" }
    )
    
    content = response.choices.first.message.content
    listing.update(summary: JSON.parse(content))
  end

  private

  attr_reader :listing, :client

  def system_prompt
    <<~PROMPT
      You are a helpful assistant that summarizes text for events that take place in New York City. 
      Given a short summary return a JSON object with the following fields. Some of the fields may not be present, so return them with null values.
      - title: 6 words or less
      - description: 30 words or less
      - day: the day of the event
      - time: The time of the event
      - location: The location of the event
      - price: The price of the event
      - categories: An array of categories that the event belongs to (including but not limited to "music", "food", "art", "fashion", "book", "tech", "sports", "halloween", "(insert holiday here)", "LGBTQ+", etc)
    PROMPT
  end
end 