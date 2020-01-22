require('pg')
require_relative('../db/sql_runnner.rb')


class Album
  attr_reader :id, :album_name, :genre, :artist_id

  # not sure if I need attr_accessor at a later point,
  #however was not sure whether I'll need to change anything
  # in the keys till later.REVIEW.
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @album_name = options['album_name']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums
    (
      album_name,
      genre,
      artist_id
    ) VALUES
    (
      $1, $2, $3
      ) RETURNING id"
    values = [@album_name, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end



  def update()
    sql = "
    UPDATE albums SET (
      album_name,
      genre,
      artist_id
      ) =
      (
        $1, $2, $3
      )
      WHERE id = $4"
      values = [@album_name, @genre, @artist_id, @id]
      SqlRunner.run(sql, values)
      # end
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql,values)
    name_hash = results.first
    name = Album.new(name_hash)
    return name
  end

  def self.find_by_album(album)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [@album_name]
    results = SqlRunner.run(sql,values)
    name_hash = results.first
    name = Album.new(name_hash)
    return name
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    names = SqlRunner.run(sql)
    return names.map{|names| Album.new(names)}
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    results = SqlRunner.run(sql, values)
    artist_data = results.first
    artist = Artist.new(artist_data)
    return artist
  end
end
