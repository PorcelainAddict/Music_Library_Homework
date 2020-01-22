require('pg')
require_relative('../db/sql_runnner.rb')

class Artist

  attr_reader :id, :artist_name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @artist_name = options['artist_name']
  end

  def save()
    sql = "INSERT INTO artists
    (artist_name) VALUES ($1) RETURNING id"
    values = [@artist_name]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    name_hash = results.first
    name = Artist.new(name_hash)
    return name
  end

  def self.find_by_artist(artist)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_name]
    results = SqlRunner.run(sql,values)
    name_hash = results.first
    name = Arist.new(name_hash)
    return name
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM artists;"
    artists = SqlRunner.run(sql)
    return artists.map{|band| Artist.new(band)}
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    collection = results.map{|collection| Album.new(collection)}
    return collection
  end
end
