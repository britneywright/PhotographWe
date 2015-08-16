FactoryGirl.define do
  factory :photograph do
    source { Faker::Avatar.image }
    association :album

    factory :complete_photograph do
      association :album
      association :uploader, factory: :user
      caption "This is the first photograph!"
    end

    factory :invalid_photograph do
      source nil
    end
  end

end
