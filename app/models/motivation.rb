class Motivation < ApplicationRecord
  belongs_to :user

  enum emotion_status: { positive: 0, negative: 1, to_do: 2, want: 3 }

  with_options presence: true do
    validates :appetite, uniqueness: { scope: :user }
    validates :memory
  end

  # ポジティブモチベーションを表示
  scope :positives, -> {where(emotion_status: 0)}
  # ネガティブモチベーションを表示
  scope :negatives, -> {where(emotion_status: 1)}
  # したいことリストを表示
  scope :to_dos, -> {where(emotion_status: 2)}
  # ほしい物リストを表示
  scope :wants, -> {where(emotion_status: 3)}

end
