class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :driver_number
      t.string :pin
      t.string :puid

      t.timestamps null: false
    end
    add_index :users, :driver_number, unique: true
  end
end
