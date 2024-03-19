class CreateSpreeOpenAi < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_open_ais do |t|
      t.string :api_token
      t.references :store, foreign_key: { to_table: :spree_stores }

      t.timestamps
    end
  end
end
