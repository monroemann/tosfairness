class Contract < ApplicationRecord
  belongs_to :user, optional: true

  validates :company_name, uniqueness: true, presence: true
  validates :website, uniqueness: true, presence: true

  before_save :calculate_total

  scope :name_like, -> (name) { where("company_name ilike ? or website ilike ?", name, name) }
  scope :top_ten,   -> { order(total_rating: :desc).limit(10) }
  scope :last_ten,  -> { order(total_rating: :asc).limit(10) }

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
