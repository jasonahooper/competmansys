class AddHomeAddressToUser < ActiveRecord::Migration
  def change
    add_column :users, :home_address, :string
  end
end
