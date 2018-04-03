class DropTablePipedriveTokens < ActiveRecord::Migration[5.1]
  def change
    drop_table :pipedrive_tokens
  end
end
