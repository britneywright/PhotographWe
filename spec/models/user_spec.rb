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
    first_user = create(:user)
    second_user = build(:user, username: first_user.username, email: "test@example.com")
    expect(second_user).to be_invalid
    expect(second_user.errors[:username]).to include("has already been taken")
  end

  it "is invalid without a unique email address" do
    first_user = create(:user)
    second_user = build(:user, email: first_user.email, username: "johndoe")
    expect(second_user).to be_invalid
    expect(second_user.errors[:email]).to include("has already been taken")
  end
end
