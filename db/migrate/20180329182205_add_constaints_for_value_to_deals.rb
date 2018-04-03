class AddConstaintsForValueToDeals < ActiveRecord::Migration[5.1]
  def change
    change_column :deals, :value, :integer, allow_nil: false, allow_nil: false, default: 0
    # add_index :deals, :value, allow_nil: false, default: 0 
  end
end
