module Spree
  module Admin
    class OpenAisController < Spree::Admin::BaseController
      include EnsureOpenai

      before_action :find_open_ai, only: [:edit, :update]

      def edit
        unless @open_ai = current_store.open_ai
          @open_ai =  Spree::OpenAi.create!(store: current_store)
        end
      end

      def update
        @open_ai.update(open_ai_params)

        flash[:success] = Spree.t(:successfully_updated, scope: :open_ai)
        redirect_to edit_admin_open_ai_path
      end

      private

      def find_open_ai
        @open_ai = current_store.open_ai
      end

      def open_ai_params
        params.require(:open_ai).permit!.merge(store: current_store)
      end

    end
  end
end
