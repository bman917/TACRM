# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    factory :person do
      first_name 'Juan'
      last_name 'Dela Cruz'
      profile_type 'INDIVIDUAL'
    end
  end
end
