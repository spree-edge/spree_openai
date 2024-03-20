module SpreeOpenai
  module StoreDecorator
    def self.prepended(base)
      base.has_one :open_ai
    end
  end
end

::Spree::Store.prepend SpreeOpenai::StoreDecorator
