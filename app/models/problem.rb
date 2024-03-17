class Problem < ApplicationRecord
  belongs_to :user
  has_many :missions,dependent: :destroy
  has_many :schedules,dependent: :destroy

  enum progress_status: { progress: 0, finish: 1, pending: 2 }

  with_options presence: true do
    validates :commitment
    validates :purpose
  end

  # 表示形式がランダム表示
  default_scope -> { order(updated_at: :desc) }
  # 進行中の目標を表示
  scope :activity, -> {where(progress_status: 0)}
  # 完了した目標を表示
  scope :finish, -> {where(progress_status: 1)}
  # 保留した目標を表示
  scope :pending, -> {where(progress_status: 2)}

end