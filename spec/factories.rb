FactoryGirl.define  do 
	factory :user do
		sequence(:name) { |n| "person#{n}" }
		sequence(:email) { |n| "person#{n}@example.com" }
		password "foobar"
		password_confirmation "foobar"

		factory :admin do
			admin true
		end
	end

	factory :micropost do
		content "Years ago when I was younger..."
		user
	end
end
	