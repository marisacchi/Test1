class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :photos
  has_many :reservations
  has_many :reviews

  geocoded_by :full_street_address
  after_validation :geocode

  validates :listing_type, presence: true
  validates :experience_type, presence: true
  validates :expert_level, presence: true
  validates :fitness_level, presence: true
  validates :listing_name, presence: true, length: {maximum: 50}
  validates :summary, presence: true, length: {maximum: 500}
  validates :accommodate, presence: true
  validates :street, presence: true
  validates :suburb, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :post_code, presence: true
  validates :country, presence: true


  def full_street_address
    [street, suburb, city, state, post_code, country].compact.join(', ')
    #this is an array, see profile model full name
  end

  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:star).round(2)
  end
end
