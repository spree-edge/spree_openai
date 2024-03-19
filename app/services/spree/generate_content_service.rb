module Spree
  class GenerateContentService < BaseService
    require 'net/http'
    require 'json'

    TASKS = {
      'caption' => 'You are a world class generator of writing captions. You will need to write a caption.',
      'description' => 'You are a world class generator of writing descriptions. You will need to write a description.',
      'product_description' => 'You are a world class generator of writing product descriptions. You will need to write a product_description.',
      'article' => 'You are a world class generator of writing articles. You will need to write a article.',
      'short_description' => 'You are a world class generator of writing short descriptions. You will need to write a short description.',
    }

    def self.generate_content(context, task = 'caption', tone_of_voice = 'sophisticated', current_store)
      message = [
        {
          "role": "system",
          "content": "#{TASKS[task]} Your tone of vocie should be #{tone_of_voice}",
        },
        {
            "role": "user",
            "content": context
        }
      ]
      execute_open_ai(message, current_store)
    end
  end
end
