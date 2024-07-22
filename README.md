# Music Library API

This is a Rails-based API for managing and playing music from a digital library, similar to iTunes or Spotify. The API provides functionality for playing songs, albums, and playlists, as well as grouping songs by genre, artist, and album.

## Requirements

- **Node.js**: v12.x or higher
- **Ruby**: v3.1.0 or higher
- **Rails**: v7.x or higher

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/joelrojo/atticus.git
cd atticus
```

### Install Dependencies

```bash
bundle install
```

### Database Setup

```bash
rails db:create
rails db:migrate
rails db:seed
```

### Run the Server

```bash
rails server
```

The API will be accessible at http://localhost:3000.


## Overview of Models
### User
- Attributes: email, password

### Artist
- Attributes: name, slug

### Genre
- Attributes: name, slug

### Album
- Attributes: title, release_date, slug, artist_id, genre_id, image (ActiveStorage attachment)

### Song
- Attributes: title, duration, mp3_url, slug, artist_id, album_id, genre_id

### Playlist
- Attributes: name, description, slug, user_id

### PlaylistSong (Join Table)
- Attributes: playlist_id, song_id

## ERD diagram

Located under the `docs` folder

## API Routes

### Users
- POST /users: Create a new user
- PUT /users/:id: Update an existing user
- DELETE /users/:id: Delete a user

### Artists
- GET /artists: List all artists
- GET /artists/:id: Show a specific artist

###Genres
- GET /genres: List all genres
- GET /genres/:id: Show a specific genre

### Albums
- GET /albums: List all albums
- GET /albums/:id: Show a specific album
- POST /albums: Create a new album
- PUT /albums/:id: Update an existing album
- DELETE /albums/:id: Delete an album
- POST /albums/:id/play: Play an album

### Songs
- GET /songs: List all songs (supports pagination with page and per_page parameters)
- GET /songs/:id: Show a specific song
- POST /songs: Create a new song
- DELETE /songs/:id: Delete a song
- POST /songs/:id/play: Play a song

### Playlists
- GET /playlists: List all playlists
- GET /playlists/:id: Show a specific playlist
- POST /playlists: Create a new playlist
- PUT /playlists/:id: Update an existing playlist
- DELETE /playlists/:id: Delete a playlist
- POST /playlists/:id/play: Play a playlist
- POST /playlists/:id/add_song: Add a song to a playlist
- DELETE /playlists/:id/remove_song: Remove a song from a playlist

## Areas for Improvement

### Implement Pagination Across All Models:

Currently, pagination is only implemented for songs. Extending pagination to other models like albums, artists, genres, and playlists would improve performance and usability.


### Add Authentication and Authorization for Playlists:

Implement user authentication and authorization to ensure that only the playlist owners can modify their playlists. This could be done using Devise for authentication and Pundit or CanCanCan for authorization.

### Add Sorting for Playlists:

Allow users to sort playlists based on different attributes like name, creation date, etc. This would enhance the user experience by providing more control over the playlist order.

### Add tests

Started basic implementation of tests using RSpec. Need to add more tests to cover all endpoints and models and ensure that they are working as expected.