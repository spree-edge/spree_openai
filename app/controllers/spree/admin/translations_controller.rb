module Spree
  module Admin
    class TranslationsController < Spree::Admin::BaseController
      before_action :load_translation_params, only: :translate

      def translate
        translations = translate_content

        if translations.value?(nil)
          flash[:error] = Spree.t('open_ai.rate_limit_error')
          redirect_back fallback_location: admin_path
        else
          respond_to do |format|
            format.json { render json: { translations: translations, field: @field } }
          end
        end
      end

      private

      def load_translation_params
        @content = translation_params[:content]
        @locales = translation_params[:locales].split(',') - ['en']
        @field = translation_params[:field]
      end

      def translate_content
        translations = {}
        @locales.each do |locale|
          translated_text = Spree::TranslationService.frame_context_for_translation(@content,'en', locale, current_store)
          translations[locale] = translated_text
        end
        translations
      end

      def translation_params
        params.permit(:content, :locales, :field)
      end
    end
  end
end
