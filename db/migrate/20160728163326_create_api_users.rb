class CreateApiUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :api_users do |t|
      t.string :auth_token

      t.timestamps
    end
  end
end
