require 'rails_helper'

RSpec.describe User do
  it "is valid with username, password, email, first name, and last name" do
    expect(create(:user)).to be_valid
  end

  it "is invalid without a username" do
    user = build(:user, username: nil)
    expect(user).to be_invalid
    expect(user.errors[:username]).to include("can't be blank")
  end

  it "is invalid without a password" do
    user = build(:user, password: nil)
    expect(user).to be_invalid
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid without an email address" do
    user = build(:user, password: nil)
    expect(user).to be_invalid
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid without a first name" do
    user = build(:user, first_name: nil)
    expect(user).to be_invalid
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without a last name" do
    user = build(:user, last_name: nil)
    expect(user).to be_invalid
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without a unique username" do
    create(:user)
    user = build(:user, username: "janedog", email: "test@example.com")
    expect(user).to be_invalid
    expect(user.errors[:username]).to include("has already been taken")
  end

  it "is invalid without a unique email address" do
    create(:user)
    user = build(:user, email: "janedog@example.com", username: "johndoe")
    expect(user).to be_invalid
    expect(user.errors[:email]).to include("has already been taken")
  end
end
