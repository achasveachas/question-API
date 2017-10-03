class AddCounterToTenant < ActiveRecord::Migration
  def change
    add_column :tenants, :counter, :integer, default: 0
  end
end
