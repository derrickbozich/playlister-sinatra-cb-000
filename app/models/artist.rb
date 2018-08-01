class Artist<ActiveRecord::Base
  has_many :songs
  has_many :genres, :through => :songs

  def slug
    slug = self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    artist = Artist.all.find {|artist| artist.slug == slug}
  end




end

class Song<ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, :through => :song_genres

  def slug
    slug = self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    song = Song.all.find {|song| song.slug == slug}
  end
end

class Genre<ActiveRecord::Base
  has_many :song_genres
  has_many :songs, :through => :song_genres
  has_many :artists, :through => :songs

  def slug
    slug = self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    genre = Genre.all.find {|genre| genre.slug == slug}
  end

end

class SongGenre<ActiveRecord::Base
  belongs_to :song
  belongs_to :genre
end
