class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :password_digest
      t.string :email, limit: 64
      t.string :first_name, limit: 64
      t.string :last_name, limit: 64
      t.string :phone, limit: 64
      t.binary :encrypted_password
      t.string :street_address, limit: 64
      t.string :city, limit: 64
      t.string :state, limit: 64

      t.timestamps
    end
  end
end
