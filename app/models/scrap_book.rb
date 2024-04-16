class ScrapBook < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  # 表示形式をランダム表示
  default_scope -> { order("RANDOM()") }

  validates :photo, presence: true

  # 表示する画像のサイズ変更用メソッド
  def get_photo(width,height)
    photo.variant(resize_to_limit: [width,height]).processed
  end

end