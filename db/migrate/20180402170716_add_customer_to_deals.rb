class AddCustomerToDeals < ActiveRecord::Migration[5.1]
  def change
    add_column :deals, :customer, :string
  end
end
