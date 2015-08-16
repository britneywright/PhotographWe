class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photographs
  validates :name, :user, presence: true
  with_options if: :private_album? do |album|
    album.validates :secret_key, presence: true
    album.validates :secret_key, length: {minimum: 6}
  end
end
