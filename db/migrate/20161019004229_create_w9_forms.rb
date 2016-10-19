class CreateW9Forms < ActiveRecord::Migration[5.0]
  def change
    create_table :w9_forms do |t|
      t.references :user, foreign_key: true
      t.binary :salt
      t.binary :encrypted_ssn
      t.binary :encrypted_tax_id

      t.timestamps
    end
  end
end
