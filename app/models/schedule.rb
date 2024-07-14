class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :problem
  has_many :plans, dependent: :destroy

  # 親モデルを保存するときに、Associationで関連づけた子モデルも一緒に保存する
  accepts_nested_attributes_for :plans, allow_destroy: true

  validates :problem_id, presence: true
  validates :title, presence: true

  # context: :create_scheduleをsaveに引数として渡した場合、またはupdateの時のみバリデーションする
	with_options presence: true, on: %i[update create_schedule] do
    validates :start_datetime
    validates :end_datetime
  end

  # context: :create_scheduleをsaveに引数として渡した場合、またはupdateの時のみバリデーションする
  validate :start_end_check, on: %i[update create_schedule]

  #時間の矛盾を防ぐ
  def start_end_check
    if self.start_datetime.present? && self.end_datetime.present?
      errors.add(:end_datetime, "が開始時刻を上回っています。正しく記入してください。") if self.start_datetime > self.end_datetime || self.start_datetime == self.end_datetime
    end
  end

  # 表示形式をランダム表示
  default_scope -> { order(start_datetime: :asc) }
  # 過去のスケジュールを表示
  scope :completion, -> {where('end_datetime <= ?', Time.current)}
  # 日付が未入力のスケジュールを表示
  scope :pending, -> {where(start_datetime: nil, end_datetime: nil)}
  # 未来のスケジュールを表示
  scope :imperfect, -> {where('start_datetime >= ?', Time.current).or(where('start_datetime < ?', Time.current)).and(where('end_datetime > ?', Time.current))}

end