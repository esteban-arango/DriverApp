class CreatePaymentSources < ActiveRecord::Migration
  def change
    create_table :payment_sources do |t|
      t.string :token
      t.string :name
      t.string :brand
      t.string :last_four
      t.string :card_holder
      t.boolean :active, default: true
      t.integer :rider_id, foreign_key: { to_table: 'user' }

      t.timestamps null: false
    end
  end
end
