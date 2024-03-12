class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :problem
  has_many :plans,dependent: :destroy
  accepts_nested_attributes_for :plans, allow_destroy: true

  default_scope -> { order(start_datetime: :asc) }
  scope :completion, -> {where('end_datetime <= ?', Time.current)}
  scope :pending, -> {where(start_datetime: nil, end_datetime: nil)}
  scope :imperfect, -> {where('start_datetime >= ?', Time.current)}

  validates :problem_id, presence: true
  validates :title, presence: true
  # context: :create_scheduleをupdate、saveに引数として渡した場合のみバリデーションする
	with_options presence: true, on: %i[update create_schedule] do
    validates :start_datetime
    validates :end_datetime
  end

  validate :start_end_check, on: %i[update create_schedule]

    #時間の矛盾を防ぐ
  def start_end_check
    if self.start_datetime.present? && self.end_datetime.present?
      errors.add(:end_datetime, "が開始時刻を上回っています。正しく記入してください。") if self.start_datetime > self.end_datetime || self.start_datetime == self.end_datetime
    end
  end

end