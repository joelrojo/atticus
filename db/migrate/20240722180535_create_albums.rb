class CreateAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :albums do |t|
      t.string :title
      t.references :artist, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.date :release_date
      t.string :image_url
      t.string :slug

      t.timestamps
    end
  end
end
