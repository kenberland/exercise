def encrypt(data, iv)
  cipher = OpenSSL::Cipher::AES.new(128, :CBC)
  cipher.encrypt
  cipher.key = KEY
  cipher.iv = iv
  cipher.update(data) + cipher.final
end

FactoryGirl.define do
  factory :w9_form do

    before(:create) do |w9_form|
      iv = OpenSSL::Cipher::AES.new(128, :CBC).random_iv
      ssn = Faker::Number.number(9)
      tax_id = Faker::Number.number(9)
      w9_form.salt = iv

      w9_form.encrypted_ssn = encrypt(ssn, iv)
      w9_form.encrypted_tax_id = encrypt(tax_id, iv)
    end
  end
end
