class Contract < ApplicationRecord
  include PgSearch
  belongs_to :user, optional: true

  pg_search_scope :company_search,
                  :against => [:company_name, :website]

  validates :company_name, uniqueness: true, presence: true
  validates :website, uniqueness: true, presence: true

  before_save :calculate_total

  def calculate_total
    self.total_rating = self.rating_1 +
                          self.rating_2 +
                          self.rating_3 +
                          self.rating_4 +
                          self.rating_5 +
                          self.rating_6 +
                          self.rating_7 +
                          self.rating_8 +
                          self.rating_9 +
                          self.rating_10
  end
end
