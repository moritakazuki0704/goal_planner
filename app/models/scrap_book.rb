class ScrapBook < ApplicationRecord
  belongs_to :user
  has_one_attached :photo


  default_scope -> { order("RANDOM()") }
  validates :photo, presence: true

  def get_photo(width,height)
    photo.variant(resize_to_limit: [width,height]).processed
  end

end