module SpreeOpenai
  module Spree
    module Admin
      module ProductsControllerDecorator
        def self.prepended(base)
          base.before_action :permitted_modal_params, only: :generate_description
        end

        def generate_description
          description = ::Spree::GenerateContentService.generate_content(context, task = 'product_description', tone_of_voice, current_store)

          respond_to do |format|
            format.turbo_stream do
              render turbo_stream: turbo_stream.replace( "productDescriptionFrame",
                partial: "spree/admin/products/description", locals: { description: description }
              )
            end
          end
        end

        private

        def permitted_modal_params
          params.permit(:features_and_keywords, :tone_of_voice, :custom_tone_of_voice, :special_instructions)
        end

        def context
          context = "features, keywords are #{permitted_modal_params[:features_and_keywords]} and special instructions are #{permitted_modal_params[:special_instructions]}"
        end

        def tone_of_voice
          tone_of_voice = permitted_modal_params[:tone_of_voice] || permitted_modal_params[:custom_tone_of_voice]
        end
      end
    end
  end
end
::Spree::Admin::ProductsController.prepend SpreeOpenai::Spree::Admin::ProductsControllerDecorator
