class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :problem
  has_many :plans,dependent: :destroy

  default_scope -> { order(start_time: :asc) }
  scope :completion, -> {where('finish_time <= ?', Time.current)}
  scope :pending, -> {where(start_time: nil, finish_time: nil)}
  scope :imperfect, -> {where('start_time >= ?', Time.current)}

  validate :start_finish_check, on: :create_schedule

  validates :problem_id, presence: true
  validates :title, presence: true
  # context: :create_scheduleをupdate、saveに引数として渡した場合のみバリデーションする
	with_options presence: true, on: :create_schedule do
    validates :start_time
    validates :finish_time
  end

   #時間の矛盾を防ぐ
   def start_finish_check
     if self.start_time.present? && self.finish_time.present?
       errors.add(:finish_time, "が開始時刻を上回っています。正しく記入してください。") if self.start_time > self.finish_time
     end
   end

end