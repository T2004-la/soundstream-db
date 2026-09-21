# Design Document: SoundStream Music Database

By **Tara Latifi**

Video URL: https://youtu.be/TcybBBd_ZHU

## Purpose

The SoundStream database is designed to power a music streaming platform similar to Spotify or Apple Music. The purpose of this database is to efficiently manage core data entities required for music playback systems, including users, artists, music albums, individual tracks, and customizable user playlists.

This database provides a scalable backend schema capable of tracking relational mapping between users and their created content, as well as providing quick read operations for music searching and playlist retrieval.

## Scope

The scope of the SoundStream database includes:
* **User Management:** Storing basic user profile information (usernames, emails, join dates).
* **Catalog Management:** Storing artist profiles, music albums, and individual audio tracks along with metadata such as track duration and release years.
* **User Personalization:** Allowing users to create custom playlists and add/remove songs dynamically.

### Out of Scope
* Payment processing, subscription tiers, and financial transactions.
* User-to-user social networking features (e.g., following other users or direct messaging).
* File storage for actual audio binaries (MP3/FLAC files); the database stores metadata only.

## Functional Requirements

This database will support the following common user tasks:
* Registering new users on the platform with unique identifiers.
* Cataloging artists, albums, and tracks with their relational hierarchy.
* Creating customizable user playlists and linking songs to them via a junction relationship.
* Executing search queries for tracks by title and artists by name with optimized index lookup times.
* Accessing simplified view representations of complex multi-table playlist joins.

## Representation

### Entities

The database consists of the following 6 core entities:

#### 1. Users
Stores information about registered listeners on the platform.
* `id`: INTEGER PRIMARY KEY - Unique identifier for each user.
* `username`: TEXT NOT NULL UNIQUE - Public display name for the user.
* `email`: TEXT NOT NULL UNIQUE - Email address for user authentication.
* `joined_date`: NUMERIC DEFAULT CURRENT_TIMESTAMP - Timestamp of registration.

#### 2. Artists
Stores information about music creators.
* `id`: INTEGER PRIMARY KEY - Unique identifier for each artist.
* `name`: TEXT NOT NULL - Name of the band or musical artist.
* `genre`: TEXT NOT NULL - Primary genre associated with the artist.

#### 3. Albums
Represents collections of songs released under an artist.
* `id`: INTEGER PRIMARY KEY - Unique identifier for the album.
* `title`: TEXT NOT NULL - Album title.
* `artist_id`: INTEGER FOREIGN KEY - References the `artists` table.
* `release_year`: INTEGER NOT NULL - Year the album was released.

#### 4. Songs
Represents individual audio tracks within an album.
* `id`: INTEGER PRIMARY KEY - Unique identifier for the song.
* `title`: TEXT NOT NULL - Track title.
* `album_id`: INTEGER FOREIGN KEY - References the `albums` table.
* `duration_seconds`: INTEGER NOT NULL - Length of the track in seconds.

#### 5. Playlists
Represents collections created by users.
* `id`: INTEGER PRIMARY KEY - Unique identifier for the playlist.
* `title`: TEXT NOT NULL - User-defined playlist title.
* `user_id`: INTEGER FOREIGN KEY - References the owner in the `users` table.
* `created_at`: NUMERIC DEFAULT CURRENT_TIMESTAMP - Creation timestamp.

#### 6. Playlist_Songs
A junction table establishing a Many-to-Many relationship between playlists and songs.
* `playlist_id`: INTEGER FOREIGN KEY - References the `playlists` table.
* `song_id`: INTEGER FOREIGN KEY - References the `songs` table.
* Composite Primary Key: (`playlist_id`, `song_id`).

## Relationships

The entities relate to each other as follows:
* **One-to-Many between Artists and Albums:** An artist can produce multiple albums, but an album belongs to exactly one artist.
* **One-to-Many between Albums and Songs:** An album contains multiple tracks, but a track belongs to one album.
* **One-to-Many between Users and Playlists:** A user can create multiple playlists, but a playlist is owned by a single user.
* **Many-to-Many between Playlists and Songs:** A playlist can contain many songs, and a single song can appear in multiple user playlists. This is implemented via the `playlist_songs` junction table.

## Optimizations

To ensure query efficiency and rapid lookups:
1. **Indexes:**
   * `song_title_index`: Created on `songs(title)` to accelerate user searches for specific track names.
   * `artist_name_index`: Created on `artists(name)` to optimize searching by artist name.
2. **Views:**
   * `playlist_details`: A predefined SQL view that pre-joins `playlists`, `users`, `playlist_songs`, `songs`, `albums`, and `artists`. This simplifies client-side queries by eliminating the need to write complex multi-table JOIN statements when rendering a playlist screen.

## Limitations

* **Single Artist Ownership:** The current schema assumes each album belongs to a single artist. Collaborations or multi-artist features require a junction table between `albums` and `artists`.
* **Static Genres:** Genres are currently plain text strings within the `artists` table rather than a separate lookup table, which may lead to redundant values.