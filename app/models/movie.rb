class Movie < ApplicationRecord
  has_many :likes
  has_many :watches
  has_many :users, through: :likes
  has_many :users, through: :watches
end
