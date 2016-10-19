class W9Form < ApplicationRecord
  belongs_to :user

  def decrypt(data)
    decipher = OpenSSL::Cipher::AES.new(128, :CBC)
    decipher.decrypt
    decipher.key = KEY
    decipher.iv = salt
    decipher.update(data) + decipher.final
  end

  def tax_id
    decrypt(encrypted_tax_id)
  end

  def ssn
    decrypt(encrypted_ssn)
  end
end
