# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :air_booking do
    transaction nil
    arrival_date "2014-08-22 21:48:55"
    return_date "2014-08-22 21:48:55"
    destination_code "MyString"
    notes "MyString"
  end
end
