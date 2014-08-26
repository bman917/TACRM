# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :transaction_seq do |n|
    n
  end

  factory :transaction do
    client_id { create(:person).id}
    name { "Auto-created Trip #{generate(:transaction_seq)}" }
    type_code "Domestic Ticketing"
    status "Confirmed"
    reference_number {"ABC#{generate(:transaction_seq)}"}
    vendor_id { create(:vendor).id }
    agent_id { create(:agent).id }
    air_booking nil
  end
end
