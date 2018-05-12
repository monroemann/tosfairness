class ContractRevision < ApplicationRecord
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

  validates_presence_of :contract_date

  has_many :contract_user_ratings, dependent: :destroy
  accepts_nested_attributes_for :contract_user_ratings

  has_many :user_loggings, dependent: :destroy
  has_many :users, through: :user_loggings
  belongs_to :contract

  before_save :calculate_total

  scope :top_ten,   -> { where("total_rating > 0").order(total_rating: :desc).limit(10) }
  scope :last_ten,  -> { where("total_rating > 0").order(total_rating: :asc).limit(10) }
  scope :recent_review, -> { where("total_rating > 0").order(updated_at: :desc).limit(10) }
  
  def contract_date=(val)
    date = Date.strptime(val, "%m/%d/%Y") if val.present?
    write_attribute(:contract_date, date)
  end

  def number_lawsuit=(val)
    score = LAWSUIT_SCORES[val]
    write_attribute(:lawsuit_score, score)
    write_attribute(:number_lawsuit, val)
  end

  def self.prior_5_year_by_contract(contract_id,prior_date, current_date)
    ContractRevision.where("contract_id = ? and contract_date >= ? and contract_date <= ?",
                    contract_id, prior_date, current_date)
  end

  def calculate_historical(val, division)
    if val.nil?
      0
    else
      val/division
    end
  end

  def self.historical_user_rating(contract_revision)
    contract_revision.save
  end

  def calculate_total
    # Get prior 5 years date
    prior_5_year_date = contract_date - 5.years

    contract_revision_ids = []

    if id.nil?
      contract_revision_ids = ContractRevision.prior_5_year_by_contract(contract_id,prior_5_year_date, contract_date).
                        pluck(:id)
    else
      contract_revision_ids = ContractRevision.prior_5_year_by_contract(contract_id,prior_5_year_date, contract_date).
                        where("id != ?", id).pluck(:id)
    end

    # prior 5 years excluding current contract revision
    prior_years_count = ContractRevision.where('id IN (?)',contract_revision_ids).
                          pluck("COUNT(id)")

    prior_years_total = ContractRevision.where('id IN (?)',contract_revision_ids).
                          pluck("SUM(rating_1 + rating_2 + rating_3 + rating_4 + rating_5 + rating_6 + rating_7 + rating_8 + rating_9 + rating_10) AS total")

    prior_years_total[0] = prior_years_total[0] == nil ? 0 : prior_years_total[0]

    prior_years_user_ratings_count = ContractUserRating.joins("INNER JOIN contract_revisions ON contract_revisions.id = contract_user_ratings.contract_revision_id").
                                      where("contract_revision_id IN (?)",contract_revision_ids).
                                      pluck("COUNT(*)")

    prior_years_user_ratings = ContractUserRating.joins("INNER JOIN contract_revisions ON contract_revisions.id = contract_user_ratings.contract_revision_id").
                                where("contract_revision_id IN (?)",contract_revision_ids).
                                pluck("SUM(rating)")

    prior_years_user_ratings[0] = prior_years_user_ratings[0] == nil ? 0 : prior_years_user_ratings[0]

    prior_years_lawsuits = ContractRevision.where('id IN (?)',contract_revision_ids).
                          pluck("SUM(lawsuit_score)")

    prior_years_lawsuits[0] = prior_years_lawsuits[0] == nil ? 0 : prior_years_lawsuits[0]

    # current contract revision
    current_year_total = rating_1 + rating_2 + rating_3 + rating_4 + rating_5 + rating_6 + rating_7 + rating_8 + rating_9 + rating_10

    current_user_ratings_count = ContractUserRating.joins("INNER JOIN contract_revisions ON contract_revisions.id = contract_user_ratings.contract_revision_id").
                                      where("contract_revision_id = ?", id).
                                      pluck("COUNT(*)")

    current_user_ratings = ContractUserRating.joins("INNER JOIN contract_revisions ON contract_revisions.id = contract_user_ratings.contract_revision_id").
                              where("contract_revision_id = ?", id).
                              pluck("SUM(rating)")

    current_user_ratings[0] = current_user_ratings[0] == nil ? 0 : current_user_ratings[0]

    # historical ratings
    if (prior_years_count[0] != nil && prior_years_count[0] > 0)
      self.rating_11 = (1.0*(prior_years_total[0] + current_year_total)/(prior_years_count[0]+1))
    else
      self.rating_11 = current_year_total
    end

    # historical user ratings
    if (prior_years_user_ratings_count[0] != nil && prior_years_user_ratings_count[0] > 0)
      if (current_user_ratings_count[0] != nil && current_user_ratings_count[0] > 0)
        self.rating_12 = (1.0*(prior_years_user_ratings[0]+current_user_ratings[0])/(prior_years_user_ratings_count[0]+current_user_ratings_count[0]))
      else
        self.rating_12 = (1.0*prior_years_user_ratings[0]/prior_years_user_ratings_count[0])
      end
    elsif (current_user_ratings_count[0] != nil && current_user_ratings_count[0] > 0)
      self.rating_12 = (1.0*current_user_ratings[0]/current_user_ratings_count[0])
    else
      self.rating_12 = 10
    end

    # historical lawsuit scores
    if (prior_years_count[0] != nil && prior_years_count[0] > 0)
      self.rating_13 = (1.0*(prior_years_lawsuits[0] + lawsuit_score)/ (prior_years_count[0]+1))
    else
      self.rating_13 = lawsuit_score
    end

    self.rating_11 = calculate_historical(self.rating_11,5.0)

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
