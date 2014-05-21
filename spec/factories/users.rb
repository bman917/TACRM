FactoryGirl.define do
  factory :user do
  	email {"#{username}@noreply.com"}

  	factory :admin do
  		username 'admin'
  		password 'password'
  		role 'Admin'
  	end
  		
  end
end
