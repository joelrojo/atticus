class RemoveImageUrlFromAlbums < ActiveRecord::Migration[7.1]
  def change
    remove_column :albums, :image_url, :string
  end
end
