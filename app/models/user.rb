class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :ideal,dependent: :destroy
  has_many :problems,dependent: :destroy
  has_many :schedules,dependent: :destroy
  has_many :motivations,dependent: :destroy
  has_many :scrap_books,dependent: :destroy

  validates :planner_name, presence: true
  # context: :create_mission_statementをsaveに引数として渡した場合のみバリデーションする
  with_options presence: true, on: :update do
    validates :mission_statement
    validates :mission_detail
  end

end
