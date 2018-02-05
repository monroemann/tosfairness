class Contract < ApplicationRecord
  belongs_to :user, optional: true

  TYPES = ['website', 'application', 'app with website', 'website with app']

  validates_inclusion_of :contract_type, in: TYPES
  validates_presence_of :contract_type

  before_save :calculate_total

  scope :top_ten,   -> { where("total_rating > 0").order(total_rating: :desc).limit(10) }
  scope :last_ten,  -> { where("total_rating > 0").order(total_rating: :asc).limit(10) }

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
                          self.rating_10 +
                          self.rating_11 +
                          self.rating_12 +
                          self.rating_13 +
                          self.rating_14 +
                          self.rating_15
  end
end
