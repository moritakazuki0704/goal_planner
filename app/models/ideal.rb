class Ideal < ApplicationRecord
  belongs_to :user

  enum ideal_status: { personality: 0, appearance: 1, lifestyle: 2, spend_time: 3, working: 4, residence: 5, relationship: 6, partner: 7, role_model: 8 }

  with_options presence: true do
    validates :ideal_status, numericality: { only_integer: true }
    validates :ideal_self
    validates :ideal_detail_self
  end

  # 表示形式をランダム表示
  default_scope -> { order("RANDOM()") }
  # 理想の性格を表示
  scope :personality, -> {where(ideal_status: 0)}
  # 理想の姿を表示
  scope :appearance, -> {where(ideal_status: 1)}
  # 理想の生活を表示
  scope :lifestyle, -> {where(ideal_status: 2)}
  # 理想の時間の使い方を表示
  scope :spend_time, -> {where(ideal_status: 3)}
  # 理想の働き方を表示
  scope :working, -> {where(ideal_status: 4)}
  # 理想の住まいを表示
  scope :residence, -> {where(ideal_status: 5)}
  # 理想の人間関係を表示
  scope :relationship, -> {where(ideal_status: 6)}
  # 理想のパートナーを表示
  scope :partner, -> {where(ideal_status: 7)}
  # 理想のモデルを表示
  scope :role_model, -> {where(ideal_status: 8)}

end