require 'spec_helper'

describe Profile, :type => :model do
  
after(:all) { DatabaseCleaner.clean }

  it "Saves an Account when it is saved" do
     p = create(:person)
     p.account = Account.new(name: p.full_name)
     p.save!

     p.reload
     assert p.account != nil
  end

  it "agent can be identified" do
  	p = build(:person, profile_type: 'AGENT')
  	expect(p.agent?).to be true
  end

 it "person can be identified" do
  	p = build(:person, profile_type: 'INDIVIDUAL')
  	expect(p.person?).to be true
  end

 describe Member, type: :model do

  before(:each) do
    @juan = create(:person)
    @juana = create(:person, first_name: "Juana", last_name: "Dela Cruz")

    @juan.add_member(profile: @juana, relationship: 'Wife')
    @juan.reload
  end

  it "has a default group named 'Default Group'" do
    expect(@juan.default_group.name).to eq 'Default Group'
  end

  it "Can be linked to a profile" do
    expect(@juan.members.count).to eq 1
    expect(@juan.members.first.profile.id).to eq @juana.id
  end

  it "Can be unliked to a profile" do
    @juan.remove_member(@juana)
    expect(@juan.members.count).to eq 0

    #make sure @juana is not destroyed
    @juana.reload
  end

  it "Does not blow if a non-member is removed" do
     not_a_member = create(:person, first_name: 'No', last_name: 'Body')
    @juan.remove_member(not_a_member)
  end
 end
end
