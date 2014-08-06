require 'spec_helper'

describe 'Profile Creation', type: :model do 

  before(:each) { Profile.destroy_all }
  after(:all) { DatabaseCleaner.clean}

  it "does not allow duplicate persons" do
    expect_no_error first_name: "Juan", middle_name: "M", last_name: "Dela Cruz", birth_day: "1900/1/1"
    expect_no_error first_name: "Juan", middle_name: "M", last_name: "Dela Cruz", birth_day: "1901/1/2"
    expect_no_error first_name: "Juana", middle_name: "M", last_name: "Dela Cruz", birth_day: "1900/1/1"
    expect_no_error first_name: "Juan", last_name: "Dela Cruz", birth_day: "1900/1/1"

    expect_error first_name: "JUAN", middle_name: "M", last_name: "Dela Cruz", birth_day: "1900/1/1"
    expect_error first_name: "JUAN", middle_name: "M", last_name: "DELA Cruz", birth_day: "1900/1/1"
    expect_error first_name: "Juan", middle_name: "M", last_name: "Dela Cruz", birth_day: "1900/1/1"
    expect_error first_name: "Juan ", middle_name: "M", last_name: "Dela Cruz", birth_day: "1900/1/1"
    expect_error first_name: "Juan", middle_name: "M ", last_name: "Dela Cruz", birth_day: "1900/1/1"
    expect_error first_name: "   Juan", middle_name: "M", last_name: "Dela Cruz", birth_day: "1900/1/1"
    expect_error first_name: "Juan", middle_name: "   M", last_name: "Dela Cruz", birth_day: "1900/1/1"
    expect_error first_name: "Juan", middle_name: "M", last_name: "   Dela Cruz", birth_day: "1900/1/1"
    expect_error first_name: " Juan ", middle_name: " M ", last_name: " Dela Cruz ", birth_day: "1900/1/1"
    expect_error first_name: "Juan", middle_name: "M", last_name: "Dela   Cruz", birth_day: "1900/1/1"

    expect_error first_name: "Juan"

    expect_no_error first_name: "Juan", last_name: "Dela Cruz"
    expect_error first_name: "Juan", last_name: "Dela Cruz"
    expect_error first_name: "Juan", last_name: "Dela       Cruz    "

  end

  it "does not allow duplicate companies" do
    expect_no_error name: "Boy Bawang Crop", profile_type: 'CORPORATE'
    expect_no_error name: "Booy Bawang Crop", profile_type: 'CORPORATE'

    expect_error name: "BOY Bawang Crop", profile_type: 'CORPORATE'
    expect_error name: "Boy Bawang Crop", profile_type: 'CORPORATE'
    expect_error name: "Boy  Bawang  Crop", profile_type: 'CORPORATE'
    expect_error name: "Boy Bawang Crop  ", profile_type: 'CORPORATE'

    expect_no_error name: "Boy Bawang Crop", business_type: 'Food', profile_type: 'CORPORATE'
    expect_no_error name: "Boy Bawang Crop", business_type: 'Travel', profile_type: 'CORPORATE'
    expect_error name: "Boy Bawang Crop", business_type: 'Food', profile_type: 'CORPORATE'
  end
end

def expect_no_error(options)
  options[:profile_type] ||= 'INDIVIDUAL'
  expect {Profile.create!(options)}.to_not raise_error, "Expecting NO error for #{options}"
end

def expect_error(options)
  options[:profile_type] ||= 'INDIVIDUAL'
  expect {Profile.create!(options)}.to raise_error, "Expecting error to be raised for #{options}"
end


