class Movie < ApplicationRecord
  has_many :likes
  has_many :watches
  has_many :users, through: :likes
  has_many :users, through: :watches

  paginates_per 15

  include PgSearch
  pg_search_scope :search_by_title_and_year,
    against: [ :title, :year ],
    using: {
      tsearch: { prefix: true }
    }
end
