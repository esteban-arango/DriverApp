class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :latitude
      t.string :longitude
      t.integer :status, default: 0
      t.integer :payment_status, default: 0
      t.integer :payment_source_id
      t.integer :rider_id, foreign_key: { to_table: 'user' }
      t.integer :driver_id, foreign_key: { to_table: 'user' }

      t.timestamps null: false
    end
  end
end
