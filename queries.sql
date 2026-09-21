-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- Common queries executed on the database

-- Add a new user
INSERT INTO "users" ("username", "email")
VALUES ('alex', 'alex@example.com');

-- Add a new artist
INSERT INTO "artists" ("name", "genre")
VALUES ('Daft Punk', 'Electronic');

-- Find all songs by a specific artist
SELECT "songs"."title", "albums"."title" AS "album"
FROM "songs"
JOIN "albums" ON "songs"."album_id" = "albums"."id"
JOIN "artists" ON "albums"."artist_id" = "artists"."id"
WHERE "artists"."name" = 'Daft Punk';

-- Create a playlist
INSERT INTO "playlists" ("title", "user_id")
VALUES ('Workout Beats', 1);

-- Get details of a specific playlist using the created view
SELECT * FROM "playlist_details"
WHERE "playlist_id" = 1;

-- Delete a song from a playlist
DELETE FROM "playlist_songs"
WHERE "playlist_id" = 1 AND "song_id" = 5;