FactoryGirl.define do
  factory :album do
    name "My first album"
    description "this is the description of my album"
    private_album false
    secret_key nil
    association :user
    
    factory :private_album do
      private_album true
      secret_key "a2c4d5"
    end
  end
end
