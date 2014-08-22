# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    client_id 1
    name "MyString"
    type_code "MyString"
    status "MyString"
    reference_number "MyString"
    vendor_id "MyString"
    agent_id "MyString"
    air_booking nil
  end
end
