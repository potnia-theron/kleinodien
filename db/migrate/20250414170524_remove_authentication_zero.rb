class RemoveAuthenticationZero < ActiveRecord::Migration[8.0]
  def change
    # standard:disable Rails/ReversibleMigration
    drop_table :password_reset_tokens
    drop_table :email_verification_tokens
    drop_table :sessions
    drop_table :users
    # standard:enable Rails/ReversibleMigration
  end
end
