class CreateDeals < ActiveRecord::Migration[5.1]
  def change
    create_table :deals do |t|
      t.references :created_by, foreign_key: { to_table: :users }
      t.references :user, foreign_key: true
      t.references :organization, foreign_key: true
      t.references :pipeline, foreign_key: true
      t.integer :status
      t.text :description
      t.string :title
      t.integer :value
      t.integer :currency
      t.integer :weighted_value
      t.integer :weighted_currency
      t.datetime :expected_closing_date
      t.datetime :won_at
      t.datetime :lost_at

      t.timestamps
    end
  end
end
