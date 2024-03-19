module SpreeScriptManagement
  module Spree
    module StoreDecorator
      def self.prepended(base)
        base.has_one :open_ai
      end
    end
  end
end

::Spree::Store.prepend SpreeScriptManagement::Spree::StoreDecorator
