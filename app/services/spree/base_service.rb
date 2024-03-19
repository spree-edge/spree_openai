module Spree
  class BaseService

    URL = "https://api.openai.com/v1/chat/completions".freeze

    def self.execute_open_ai(message, current_store)
      url = URI.parse(URL)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      headers = {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{TOKEN(current_store)}"
      }

      data = {
        "model": "gpt-3.5-turbo-16k",
        "messages": message,
        "temperature": 0.7,
        "max_tokens": 64,
        "top_p": 1
      }

      request = Net::HTTP::Post.new(url.path, headers)
      request.body = data.to_json

      response = http.request(request)
      response = JSON.parse(response.body)

      response.dig('choices')[0].dig('message', 'content') if response.dig('choices').present?
    end

    def self.TOKEN(current_store)
      current_store.open_ai.api_token if current_store.open_ai.present?
    end
  end
end
