class Book < ApplicationRecord
  validates :title, presence: true
  validates :opinion, presence: true
end
