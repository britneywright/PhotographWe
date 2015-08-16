FactoryGirl.define do
  factory :user do
    sequence (:username) {|n| "janedog#{n}" }
    first_name "Jane"
    last_name "Dog"
    password "outside"
    sequence (:email) {|n| "janedog#{n}@example.com" }
  end
end
