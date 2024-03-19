module EnsureOpenai
  extend ActiveSupport::Concern

  # filter for checking if this feature is enabled or not before running any controller action
  included do
    before_action :ensure_openai_enabled
  end

  def ensure_openai_enabled
    raise CanCan::AccessDenied unless Flipper.enabled?(:openai, current_store.try(:id))
  end
end
