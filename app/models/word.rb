class Word < ApplicationRecord
  belongs_to :user
  
  validates :english, presence: true, length: { maximum: 255 }
  validates :japanese, presence: true, length: { maximum: 255 }
end
