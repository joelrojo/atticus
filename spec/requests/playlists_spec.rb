require 'rails_helper'

RSpec.describe "Playlists", type: :request do
  let!(:user) { User.first || create(:user) }  # Ensure the user is created or use the first user
  let!(:playlist) { create(:playlist, user: user) }
  let!(:song) { create(:song) }

  describe "GET /playlists" do
    it "returns a list of playlists" do
      get playlists_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(playlist.name)
    end
  end

  describe "GET /playlists/:id" do
    it "returns a specific playlist" do
      get playlist_path(playlist)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(playlist.name)
    end
  end

  describe "POST /playlists" do
    it "creates a new playlist" do
      expect {
        post playlists_path, params: { playlist: { name: "New Playlist", description: "A new playlist", user_id: user.id } }
      }.to change(Playlist, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe "PUT /playlists/:id" do
    it "updates a specific playlist" do
      put playlist_path(playlist), params: { playlist: { name: "Updated Playlist" } }
      expect(response).to have_http_status(:ok)
      playlist.reload
      expect(playlist.name).to eq("Updated Playlist")
    end
  end

  describe "DELETE /playlists/:id" do
    it "deletes a specific playlist" do
      playlist_to_delete = create(:playlist, user: user)
      expect {
        delete playlist_path(playlist_to_delete)
      }.to change(Playlist, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end

  describe "POST /playlists/:id/add_song" do
    it "adds a song to the playlist" do
      post add_song_playlist_path(playlist), params: { song_id: song.id }
      expect(response).to have_http_status(:ok)
      playlist.reload
      expect(playlist.songs).to include(song)
    end
  end

  describe "DELETE /playlists/:id/remove_song" do
    before do
      playlist.songs << song
    end

    it "removes a song from the playlist" do
      delete remove_song_playlist_path(playlist), params: { song_id: song.id }
      expect(response).to have_http_status(:ok)
      playlist.reload
      expect(playlist.songs).not_to include(song)
    end
  end
end
