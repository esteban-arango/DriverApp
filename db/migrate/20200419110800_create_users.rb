class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :type
      t.boolean :driver_available, default: true

      t.timestamps null: false
    end
  end
end
