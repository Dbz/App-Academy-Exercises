class Track < ActiveRecord::Base
  TYPES = ["Bonus", "Regular"]
  
  validates :name, :album_id, presence: true
  validates :name, uniqueness: { scope: :album_id }
  validates :track_type, inclusion: { in: TYPES }
  belongs_to :album
  has_one(
    :band,
    through: :album,
    source: :band
  )
  has_many :notes
end