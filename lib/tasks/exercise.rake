namespace 'exercise' do
  desc 'Make some fake data to use'
  task make_fake: :environment do
    num = ENV['NUM'] || 10

    num.to_i.times do |i|
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:w9_form, user_id: user.id)
    end
  end
end
