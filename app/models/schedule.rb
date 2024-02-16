class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :problem
  has_many :plans,dependent: :destroy

  default_scope -> { order(start_time: :asc) }
  scope :completion, -> {where(end: :finish_time < Time.current)}
  scope :pending, -> {where(start_time: nil, finish_time: nil)}
  scope :imperfect, -> {where(start_time: :finish_time >= Time.current)}

  validate :start_finish_check
  validate :start_check
  validates :commit_id, presence: true
  validates :title, presence: true
  # context: :create_scheduleをupdate、saveに引数として渡した場合のみバリデーションする
	with_options presence: true, on: :create_schedule do
    validates :start_time
    validates :end_time
  end

   #時間の矛盾を防ぐ
  def start_finish_check
    errors.add(:finish_time, "は開始時刻より遅い時間を選択してください") if self.start_time > self.finish_time
  end

  def start_check
    errors.add(:start_time, "は現在の日時より遅い時間を選択してください") if self.start_time < Time.now
  end

end
