class Movie < ApplicationRecord

  belongs_to :director
  belongs_to :filming_location
  belongs_to :country

  has_many :movies_actors
  has_many :actors, through: :movies_actors

  has_many :reviews

end
