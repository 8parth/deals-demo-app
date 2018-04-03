class AddFieldsToPipeline < ActiveRecord::Migration[5.1]
  def change
    add_column :pipelines, :url_title, :string
    add_column :pipelines, :deal_probability, :boolean, default: false
    add_column :pipelines, :active, :boolean, default: true
    add_column :pipelines, :order_nr, :integer, default: 0
  end
end
