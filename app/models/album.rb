class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photographs, :dependent => :destroy
  accepts_nested_attributes_for :photographs
  validates :name, :user, :slug, presence: true
  with_options if: :private_album? do |album|
    album.validates :secret_key, presence: true
    album.validates :secret_key, length: {minimum: 6}
  end

  before_validation :set_slug
 
  def to_param
    slug
  end 

  def private_status
    if self.private_album
      " - private"
    end
  end
  protected

  def set_slug
    if slug.nil? || slug.empty?
      self.slug = name.parameterize
    else
      self.slug = self.slug.parameterize
    end
  end
end
