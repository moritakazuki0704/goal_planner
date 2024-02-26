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

  # updateの場合のみバリデーションする
  with_options presence: true, on: :update do
    validates :keyword_1
    validates :keyword_2
    validates :keyword_3
    validates :keyword_4
    validates :keyword_5
    validates :keyword_6
    validates :keyword_7
    validates :keyword_8
    validates :keyword_9
    validates :keyword_10
  end

    with_options presence: true, on: :update, if: :keyword_10.present? do
      validates :mission_statement
      validates :mission_statement_detail
    end


end
