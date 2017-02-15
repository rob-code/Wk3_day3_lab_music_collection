require('pry')
require_relative('models/album.rb')
require_relative('models/artist.rb')

Album.delete_all
Artist.delete_all

artist1 = Artist.new({'name' => 'Billy Bragg'})
artist1.save()

artist2 = Artist.new({'name' => 'Queen'})
artist2.save()

artist3 = Artist.new({'name' => 'The Beatles'})
artist3.save()



album1 = Album.new({'title' => 'Tooth and Nail', 'genre' => 'Folk', 'artist_id' => artist1.id})
album1.save()

album2 = Album.new({'title' => 'A Night at the Opera', 'genre' => 'Rock', 'artist_id' => artist2.id})
album2.save()

album3 = Album.new({'title' => 'Killer Queen', 'genre' => 'Rock', 'artist_id' => artist2.id})
album3.save()



binding.pry
nil