class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :fingerprint
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :devices, :fingerprint
  end
end
