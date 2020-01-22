require('pg')
require('pry')
require_relative('../models/album.rb')
require_relative('../models/artist.rb')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({'artist_name' => 'The Beastie Boys'})
artist1.save()
artist2 = Artist.new({'artist_name' => 'Jack Portwood'})
artist2.save()
artist3 = Artist.new({'artist_name' => 'Bruce Willis'})
artist3.save()


album1 = Album.new({
  'artist_id' => artist1.id,
  'album_name' => 'Hello Nasty',
  'genre' => 'Hip Hop'
  })
  album1.save()

 album2 = Album.new({
  'artist_id' => artist2.id,
  'album_name' => 'Man Shouts at Clouds(3-hour-limited-edition)',
  'genre' => 'Difficult-Listening/Educational/World'
  })
  album2.save()

  album3 = Album.new({
    'artist_id' => artist3.id,
    'album_name' => 'The Return of Bruno',
    'genre' => 'R&B, pop'
    })
    album3.save()



  binding.pry
  nil
