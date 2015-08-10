class Album < ActiveRecord::Base
  validates :name, presence: true
  with_options if: :private_album? do |album|
    album.validates :secret_key, presence: true
    album.validates :secret_key, length: {minimum: 6}
  end
end
