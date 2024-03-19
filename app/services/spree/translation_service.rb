module Spree
  class TranslationService < BaseService
    require 'net/http'
    require 'json'

    def self.frame_context_for_translation(input_text, base_language_code = 'en', target_language_code = 'fr', current_store)
      context = "You will be provided with a sentence in #{base_language_code}, and your task is to translate it into language. Here is the language code --> #{target_language_code} "
      message = [
        {
          "role": "system",
          "content": context
        },
        {
          "role": "user",
          "content": input_text
        }
      ]
      execute_open_ai(message, current_store)
    end
  end
end
