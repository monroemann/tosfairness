class ContractUserRating < ApplicationRecord
  belongs_to :user
  belongs_to :contract_revision

  USER_RATINGS = [0,1,2,3,4,5,6,7,8,9,10]

  validates_inclusion_of :rating, in: USER_RATINGS

  after_save :calculate_historical_user_rating

  def calculate_historical_user_rating
    ContractRevision.historical_user_rating(self.contract_revision)
  end
end
