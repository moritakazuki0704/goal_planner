class Mission < ApplicationRecord
  belongs_to :problem

  validates :memo, presence: true
  
end