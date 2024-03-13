class Plan < ApplicationRecord
  belongs_to :schedule

  enum priority_status: { emergency: 0, important: 1, interruption: 2, eliminate: 3 }
  enum progress_status: { unstarted: 0, finish: 1, process: 2, postpone: 3, withdraw: 4 }

  validates :challenge, presence: true

  # メモ状態のタスクを表示
  scope :memo, -> {where(programme: "false")}
  # ToDoリストにしたタスクを表示
  scope :programme, -> {where(programme: "true")}
  # ToDoリストにしたステータスが大事なことのタスクを表示
  scope :emergency, -> {where(programme: "true", priority_status: 0)}
  # ToDoリストにしたステータスが重要なことのタスクを表示
  scope :important, -> {where(programme: "true", priority_status: 1)}
  # ToDoリストにしたステータスがやるべきことのタスクを表示
  scope :interruption, -> {where(programme: "true", priority_status: 2)}
  # ToDoリストにしたステータスが辞めることのタスクを表示
  scope :eliminate, -> {where(programme: "true", priority_status: 3)}

end