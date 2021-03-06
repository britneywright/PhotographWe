class Photograph < ActiveRecord::Base
  belongs_to :album
  belongs_to :uploader, class_name: 'User'
  has_attached_file :source, 
    :styles => { :medium => "300x300#", :thumb => "200x200#" }, 
    :default_url => "/images/:style/missing.png"
  validates :album, presence: true
  validates_attachment_content_type :source, :content_type => /\Aimage\/.*\Z/
  validates :source, :attachment_presence => true

  def uploaded_by
    if uploader
      "#{uploader.first_name} #{uploader.last_name}"
    else
      "Guest"
    end
  end
end
