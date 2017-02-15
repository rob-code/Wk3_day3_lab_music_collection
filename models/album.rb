require_relative('../db/sql_runner.rb')

class Album

  attr_reader :id, :artist_id
  attr_accessor :title, :genre 

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save
    sql = "INSERT INTO albums (title, genre, artist_id) VALUES ('#{@title}', '#{@genre}', #{@artist_id}) RETURNING *;"
    returned_array = SqlRunner.run(sql)
    album_hash = returned_array.first
    id_string = album_hash['id']
    @id = id_string.to_i
  end

  def update
    sql = "UPDATE albums SET (title, genre, artist_id) =
    ('#{@title}', '#{@genre}', #{@artist_id}) 
    WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM albums WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.all
    sql "SELECT * FROM albums;"
    albums_hashes = SqlRunner.run(sql)
    albums_array = albums_hashes.map do |album|
      Album.new(album)
    end
    return albums_array
  end

  def self.delete_all
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def artist
    sql = "SELECT * FROM artists WHERE id = #{@artist_id}"
    artist_array = SqlRunner.run(sql)
    return artist_array.map {|artist| Artist.new(artist)}
  end

  def self.return_by_id(id_required)
    sql = "SELECT * FROM albums WHERE id = #{id_required}"
    albums_array = SqlRunner.run(sql)
    return albums_array.map {|album| Album.new(album)}
  end



end

