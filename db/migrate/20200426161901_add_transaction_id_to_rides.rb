class AddTransactionIdToRides < ActiveRecord::Migration
  def change
    add_column :rides, :transaction_id, :string
  end
end
