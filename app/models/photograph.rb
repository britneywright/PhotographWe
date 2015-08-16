class Photograph < ActiveRecord::Base
  belongs_to :album
  belongs_to :uploader, class_name: 'User'
  has_attached_file :source, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates :album, presence: true
  validates_attachment_content_type :source, :content_type => /\Aimage\/.*\Z/
  validates :source, :attachment_presence => true
end
