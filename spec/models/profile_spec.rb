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
end
