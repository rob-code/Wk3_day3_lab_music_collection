require_relative('../db/sql_runner.rb')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ('#{@name}') RETURNING *;"
    returned_array = SqlRunner.run(sql)
    artist_hash = returned_array.first
    id_string = artist_hash['id']
    @id = id_string.to_i
  end

  def update()
    sql = "UPDATE artists SET (name) = ('#{@name}') WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM artists;"
    artist_hashes = SqlRunner.run(sql)
    artists_array = artist_hashes.map do |artist|
      Artist.new(artist)
    end
    return artists_array
  end

  def self.delete_all()
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = #{@id};"
    album_array = SqlRunner.run(sql)
    return album_array.map {|album| Album.new(album)}
  end

  def self.return_by_id(id_required)
    sql = "SELECT * FROM artists WHERE id = #{id_required}"
    artists_array = SqlRunner.run(sql)
    return artists_array.map {|artist| Artist.new(artist)}
  end


end