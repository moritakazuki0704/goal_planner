class Motivation < ApplicationRecord
  belongs_to :user

  enum emotion_status: { positive: 0, negative: 1, to_do: 2, want: 3 }

  with_options presence: true do
    validates :appetite, uniqueness: { scope: :user }
    validates :memory
  end

  # 表示形式をランダム形式
  default_scope -> { order("RANDOM()") }
  # ポジティブモチベーションを表示
  scope :positive, -> {where(emotion_status: 0)}
  # ネガティブモチベーションを表示
  scope :negative, -> {where(emotion_status: 1)}
  # したいことリストを表示
  scope :to_do, -> {where(emotion_status: 2)}
  # ほしい物リストを表示
  scope :want, -> {where(emotion_status: 3)}

end