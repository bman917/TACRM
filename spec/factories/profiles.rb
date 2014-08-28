# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence :random do |n|
    n
  end

  factory :profile do

    factory :vendor do
      name {"Lucky Travel Corp #{generate(:random)}"}
      profile_type 'VENDOR'
      account
    end


    factory :company do
      name {"JD's Food Hall #{generate(:random)}"}
      profile_type 'CORPORATE'
      account
    end

    factory :person do
      first_name 'Juan'
      last_name 'Dela Cruz'
      middle_name {generate(:random)}

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

    factory :agent do
      first_name 'Agent'
      middle_name {generate(:random)}
      last_name 'X44'
      profile_type 'AGENT'
      account
    end
  end

  factory :note do
    note "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed o eiusmod tempor"
  end

  factory :account do
    name 'Default'
  end

  factory :identification do
    foid_type 'Passport'
  end
  
end
