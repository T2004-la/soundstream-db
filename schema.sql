-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- Schema for Spotify-like Music Streaming Platform Database

-- Represent users in the platform
CREATE TABLE "users" (
    "id" INTEGER,
    "username" TEXT NOT NULL UNIQUE,
    "email" TEXT NOT NULL UNIQUE,
    "joined_date" NUMERIC DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id")
);

-- Represent artists/musicians
CREATE TABLE "artists" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "genre" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Represent music albums
CREATE TABLE "albums" (
    "id" INTEGER,
    "title" TEXT NOT NULL,
    "artist_id" INTEGER,
    "release_year" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("artist_id") REFERENCES "artists"("id")
);

-- Represent individual songs
CREATE TABLE "songs" (
    "id" INTEGER,
    "title" TEXT NOT NULL,
    "album_id" INTEGER,
    "duration_seconds" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("album_id") REFERENCES "albums"("id")
);

-- Represent user playlists
CREATE TABLE "playlists" (
    "id" INTEGER,
    "title" TEXT NOT NULL,
    "user_id" INTEGER,
    "created_at" NUMERIC DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id")
);

-- Represent mapping between playlists and songs
CREATE TABLE "playlist_songs" (
    "playlist_id" INTEGER,
    "song_id" INTEGER,
    PRIMARY KEY("playlist_id", "song_id"),
    FOREIGN KEY("playlist_id") REFERENCES "playlists"("id"),
    FOREIGN KEY("song_id") REFERENCES "songs"("id")
);

-- Indexes for performance optimization
CREATE INDEX "song_title_index" ON "songs" ("title");
CREATE INDEX "artist_name_index" ON "artists" ("name");

-- View for user playlists summary
CREATE VIEW "playlist_details" AS
SELECT
    "playlists"."id" AS "playlist_id",
    "playlists"."title" AS "playlist_title",
    "users"."username" AS "created_by",
    "songs"."title" AS "song_title",
    "artists"."name" AS "artist_name"
FROM "playlists"
JOIN "users" ON "playlists"."user_id" = "users"."id"
JOIN "playlist_songs" ON "playlists"."id" = "playlist_songs"."playlist_id"
JOIN "songs" ON "playlist_songs"."song_id" = "songs"."id"
JOIN "albums" ON "songs"."album_id" = "albums"."id"
JOIN "artists" ON "albums"."artist_id" = "artists"."id";