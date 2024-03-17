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

  # keyword_updateの場合のみバリデーションする
  with_options presence: true, on: :keyword_update do
    validates :first_keyword
    validates :second_keyword
    validates :third_keyword
    validates :fourth_keyword
    validates :fifth_keyword
    validates :sixth_keyword
    validates :seventh_keyword
    validates :eighth_keyword
    validates :ninth_keyword
    validates :tenth_keyword
  end

  # mission_statement_updateの場合のみバリデーションする
  with_options presence: true, on: :mission_statement_update do
    validates :mission_statement
    validates :mission_statement_detail
  end

end