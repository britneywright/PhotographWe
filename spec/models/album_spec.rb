require 'rails_helper'

RSpec.describe Album do
  it "is valid with only a name" do
    expect(create(:album, description: nil)).to be_valid
  end

  it "is valid with a name and description" do
    expect(create(:album)).to be_valid
  end

  it "is not valid without a name" do
    album = build(:album, name: nil)
    expect(album).to be_invalid
    expect(album.errors[:name]).to include("can't be blank")
  end

  it "has a secret key if it's private" do
    expect(create(:private_album)).to be_valid
  end

  it "is not valid if it's marked private without a secret key" do
    private_album = build(:private_album, secret_key: nil)
    expect(private_album).to be_invalid
  end

  it "is not valid with a secret key less than six characters" do
    private_album = build(:private_album, secret_key: "123")
    expect(private_album).to be_invalid
  end
end
