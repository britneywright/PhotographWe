class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name, null: false
      t.string :description
      t.boolean :private_album
      t.string :secret_key

      t.timestamps null: false
    end
  end
end
