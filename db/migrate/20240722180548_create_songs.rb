class CreateSongs < ActiveRecord::Migration[7.1]
  def change
    create_table :songs do |t|
      t.string :title
      t.integer :duration
      t.references :artist, null: false, foreign_key: true
      t.references :album, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.string :image_url
      t.string :mp3_url
      t.string :slug

      t.timestamps
    end
  end
end
