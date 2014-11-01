class Album < ActiveRecord::Base
  validates :name, :band_id, presence: true
  validates :name, uniqueness: { scope: :band_id }
  
  has_many(
    :tracks,
    dependent: :destroy
  )
  
  belongs_to :band
end