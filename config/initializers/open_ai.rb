Rails.application.config.after_initialize do
  if Spree::Core::Engine.backend_available?
    Rails.application.config.spree_backend.main_menu.add_to_section(
      'integrations',
      ::Spree::Admin::MainMenu::ItemBuilder.new(
        'open_ai.open_ai_heading',
        ::Spree::Core::Engine.routes.url_helpers.edit_admin_open_ai_path
      )
      .with_manage_ability_check(::Spree::OpenAi)
      .with_match_path('/open_ai/edit')
      .build
    )
  end
end
