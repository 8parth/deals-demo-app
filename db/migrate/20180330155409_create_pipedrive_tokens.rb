class CreatePipedriveTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :pipedrive_tokens do |t|
      t.references :user, foreign_key: true
      t.string :token

      t.timestamps
    end
  end
end
