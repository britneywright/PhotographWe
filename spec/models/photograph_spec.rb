require 'rails_helper'

RSpec.describe Photograph do
  it { should have_attached_file(:source) }
  it { should validate_attachment_presence(:source) }
  it { should validate_attachment_content_type(:source).allowing('image/png').rejecting('text/plain', 'text/xml') }
  it { should belong_to(:uploader).class_name('User') }
  it { should belong_to(:album) }

  it "is valid with a caption and uploader" do
    expect(create(:complete_photograph)).to be_valid
  end

  it "is not valid without a source image" do
    expect(build(:invalid_photograph)).to be_invalid
  end
end
