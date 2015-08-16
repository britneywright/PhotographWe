class CreatePhotographs < ActiveRecord::Migration
  def change
    create_table :photographs do |t|
      t.attachment :source
      t.string :caption
      t.integer :album_id
      t.integer :uploader_id
      t.timestamps null: false
    end
  end
end
