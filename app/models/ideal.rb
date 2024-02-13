class Ideal < ApplicationRecord
  belongs_to :user

  with_options presence: true do
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
    validates :personality_1
    validates :personality_2
    validates :personality_3
    validates :hair_make
    validates :body_make
    validates :fashion_make
    validates :lifestyle_1
    validates :lifestyle_2
    validates :lifestyle_3
    validates :time_1
    validates :time_2
    validates :time_3
    validates :working_1
    validates :working_2
    validates :working_3
    validates :residence_1
    validates :residence_2
    validates :residence_3
    validates :relationship_1
    validates :relationship_2
    validates :relationship_3
    validates :partner_1
    validates :partner_2
    validates :partner_3
    validates :partner_model
    validates :family_model
    validates :friend_model
  end
  
end
