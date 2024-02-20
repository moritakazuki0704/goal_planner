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

end