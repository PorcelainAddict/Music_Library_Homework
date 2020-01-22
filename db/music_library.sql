DROP TABLE IF EXISTS albums;
DROP TABLE IF EXISTS artists;

CREATE TABLE artists(
  id SERIAL PRIMARY KEY NOT NULL,
  artist_name VARCHAR(255)
);

CREATE TABLE albums(
  id SERIAL PRIMARY KEY NOT NULL,
  album_name VARCHAR(255),
  genre VARCHAR(255),
  artist_id INT REFERENCES artists(id)
);
