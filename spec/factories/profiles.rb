# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do

    factory :person do
      first_name 'Juan'
      last_name 'Dela Cruz'
      profile_type 'INDIVIDUAL'
      account

      factory :person_with_notes do
        ignore do
          notes_count 1
        end
        after(:create) do |profile, evaluator|
          create_list(:note, evaluator.notes_count, profile: profile)
        end      
      end
    end
  end

  factory :note do
    note "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed o eiusmod tempor"
  end

  factory :account do
    name 'Default'
  end
  
end
