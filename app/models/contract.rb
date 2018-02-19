class Contract < ApplicationRecord
  TYPES = ['website', 'application', 'app with website', 'website with app']
  SCORES = [0,1,2,3,4,5]
  LAWSUITS = ['0','1','2','3','4','5','6','7','8','9','10+']
  BADGES = [0, 10, 20]
  LAWSUIT_SCORES = {'0' => 10,
                    '1' => 9,
                    '2' => 8,
                    '3' => 7,
                    '4' => 6,
                    '5' => 5,
                    '6' => 4,
                    '7' => 3,
                    '9' => 2,
                    '10+' => 0}

  validates_inclusion_of :contract_type, in: TYPES
  validates_inclusion_of :rating_1,
                         :rating_2,
                         :rating_3,
                         :rating_4,
                         :rating_5,
                         :rating_6,
                         :rating_7,
                         :rating_8,
                         :rating_9,
                         :rating_10, in: SCORES
  validates_inclusion_of :rating_14, in: BADGES

  validates_presence_of :contract_type
  validates_presence_of :contract_date

  has_many :contract_user_ratings, dependent: :destroy
  accepts_nested_attributes_for :contract_user_ratings

  has_many :users, through: :adopter_waitlists

  has_many :user_loggings, dependent: :destroy
  has_many :users, through: :user_loggings

  before_save :calculate_total

  scope :top_ten,   -> { where("total_rating > 0").order(total_rating: :desc).limit(10) }
  scope :last_ten,  -> { where("total_rating > 0").order(total_rating: :asc).limit(10) }

  def contract_date=(val)
    date = Date.strptime(val, "%m/%d/%Y") if val.present?
    write_attribute(:contract_date, date)
  end

  def number_lawsuit=(val)
    score = LAWSUIT_SCORES[val]
    write_attribute(:lawsuit_score, score)
    write_attribute(:number_lawsuit, val)
  end

  def self.prior_5_year_by_contract(type,company_id,prior_date, current_date)
    Contract.where("contract_type = ? and company_id = ? and contract_date >= ? and contract_date < ?",
                    type, company_id, prior_date, current_date)
  end

  def calculate_total
    # Get prior 5 years date
    prior_5_year_date = contract_date - 5.years

    contract_ids = []

    if id.nil?
      contract_ids = Contract.prior_5_year_by_contract(contract_type,company_id,prior_5_year_date, contract_date).
                        pluck(:id)
    else
      contract_ids = Contract.prior_5_year_by_contract(contract_type,company_id,prior_5_year_date, contract_date).
                        where("id != ?", id).pluck(:id)
    end
    #average total rating
    self.rating_11 = Contract.where('id IN (?)', contract_ids).
                            average(:total_rating)

    self.rating_12 = ContractUserRating.where('contract_id IN (?)', contract_ids).
                            average(:rating)

    #average lawsuit scores
    self.rating_13 = Contract.where('id IN (?)', contract_ids).
                            average(:lawsuit_score)


    self.rating_11 = 0 if self.rating_11.nil?
    self.rating_12 = 0 if self.rating_12.nil?
    self.rating_13 = 0 if self.rating_13.nil?

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
                          self.rating_14
  end
end
