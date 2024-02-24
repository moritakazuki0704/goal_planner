class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :problem
  has_many :plans,dependent: :destroy

  default_scope -> { order(start_date: :asc) }
  scope :completion, -> {where('end_date <= ?', Time.current)}
  scope :pending, -> {where(start_date: nil, end_date: nil)}
  scope :imperfect, -> {where('start_date >= ?', Time.current)}

  validates :problem_id, presence: true
  validates :title, presence: true
  # context: :create_scheduleをupdate、saveに引数として渡した場合のみバリデーションする
	with_options presence: true, on: %i[update create_schedule] do
    validates :start_date
    validates :start_time
    validates :end_date
    validates :end_time
  end

  validate :start_end_check, on: %i[update create_schedule]

    #時間の矛盾を防ぐ
  def start_end_check
    if self.start_date.present? && self.end_date.present? && self.start_time.present? && self.end_time.present?
      errors.add(:end_time, "が開始時刻を上回っています。正しく記入してください。") if self.start_date > self.end_date || self.start_date == self.end_date && self.start_time >= self.end_time
    end
  end
end