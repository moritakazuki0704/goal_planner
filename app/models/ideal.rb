class Ideal < ApplicationRecord
  belongs_to :user

  enum ideal_status: { personality: 0, appearance: 1, lifestyle: 2, spend_time: 3, working: 4, residence: 5, relationship: 6, partner: 7, role_model: 8 }

  default_scope -> { order(created_at: :asc) }
  with_options presence: true do
    validates :ideal_status, numericality: { only_integer: true }
    validates :ideal_self
    validates :ideal_detail_self
  end

  # ideal_statusがpersonality（理想の性格）のみ表示
  scope :personality, -> {where(ideal_status: 0)}
  # ideal_statusがappearance（理想の姿）のみ表示
  scope :appearance, -> {where(ideal_status: 1)}
  # ideal_statusがlifestyle（理想の生活）のみ表示
  scope :lifestyle, -> {where(ideal_status: 2)}
  # ideal_statusがspend_time（理想の時間の使い方）のみ表示
  scope :spend_time, -> {where(ideal_status: 3)}
  # ideal_statusがworking（理想の働き方）のみ表示
  scope :working, -> {where(ideal_status: 4)}
  # ideal_statusがresidence（理想の住まい）のみ表示
  scope :residence, -> {where(ideal_status: 5)}
  # ideal_statusがrelationship（理想の人間関係）のみ表示
  scope :relationship, -> {where(ideal_status: 6)}
  # ideal_statusがpartner（理想のパートナー）のみ表示
  scope :partner, -> {where(ideal_status: 7)}
  # ideal_statusがrole_model（理想のモデル）のみ表示
  scope :role_model, -> {where(ideal_status: 8)}

end
