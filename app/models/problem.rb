class Problem < ApplicationRecord
  belongs_to :user
  has_many :missions,dependent: :destroy
  has_many :schedules,dependent: :destroy

  enum progress_stetas: { process: 0, finish: 1, pending: 2 }

  validates :progress_stetas, presence: true,numericality: { only_integer: true },inclusion: { in: 0..2 }, allow_blank: true
  with_options presence: true do
    validates :commitment
    validates :purpose
  end

  # 進行中の目標を表示
  scope :activity, -> {where(progress_stetas: 0)}
  # 完了した目標を表示
  scope :finish, -> {where(progress_stetas: 1)}
  # 保留した目標を表示
  scope :pending, -> {where(progress_stetas: 2)}

end
