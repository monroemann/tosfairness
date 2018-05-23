# table name: contract_revisions
# t.integer  "contract_id"
# t.date     "contract_date"
# t.integer  "rating_1",        default: 0
# t.integer  "rating_2",        default: 0
# t.integer  "rating_3",        default: 0
# t.integer  "rating_4",        default: 0
# t.integer  "rating_5",        default: 0
# t.integer  "rating_6",        default: 0
# t.integer  "rating_7",        default: 0
# t.integer  "rating_8",        default: 0
# t.integer  "rating_9",        default: 0
# t.integer  "rating_10",       default: 0
# t.float    "rating_11",       default: 0.0   historical fairness
# t.float    "rating_12",       default: 0.0   historical user rating
# t.float    "rating_13",       default: 0.0   historical lawsuits
# t.float    "rating_14",       default: 0.0   badge placement
# t.float    "total_rating",    default: 0.0
# t.text     "rating_1_note"
# t.text     "rating_2_note"
# t.text     "rating_3_note"
# t.text     "rating_4_note"
# t.text     "rating_5_note"
# t.text     "rating_6_note"
# t.text     "rating_7_note"
# t.text     "rating_8_note"
# t.text     "rating_9_note"
# t.text     "rating_10_note"
# t.text     "additional_note"
# t.string   "number_lawsuit",  default: "0"
# t.integer  "lawsuit_score",   default: 10
# t.text     "ways_to_improve"
# t.datetime "created_at",                    null: false
# t.datetime "updated_at",                    null: false
# t.text     "lawsuit_note"
# t.string   "tos_url"
# t.text     "total_page_note"
# t.integer  "total_page"

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

  before_save :downcase_tos_url, :calculate_total

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

  def self.all_prior_year_by_contract(contract_id, current_date)
    ContractRevision.where("contract_id = ? and contract_date <= ?",
                            contract_id, current_date)
  end

  def self.historical_user_rating(contract_revision)
    contract_revision.save
  end

  def downcase_tos_url
    self.tos_url.downcase!
  end

  def calculate_total
    contract_revision_ids = []

    if id.nil?
      contract_revision_ids = ContractRevision.all_prior_year_by_contract(contract_id, contract_date).
                                pluck(:id)
    else
      contract_revision_ids = ContractRevision.all_prior_year_by_contract(contract_id, contract_date).
                                where("id != ?", id).pluck(:id)
    end

    # prior years excluding current contract revision
    prior_years_count = ContractRevision.where('id IN (?)',contract_revision_ids).
                          pluck("COUNT(id)")

    prior_years_total = ContractRevision.where('id IN (?)',contract_revision_ids).
                          pluck("SUM(rating_1 + rating_2 + rating_3 + rating_4 + rating_5 +
                            rating_6 + rating_7 + rating_8 + rating_9 + rating_10 + rating_12 +
                            rating_13 + rating_14) AS total")

    prior_years_total[0] = prior_years_total[0] == nil ? 0 : prior_years_total[0]

    # prior years user ratings
    prior_years_user_ratings_count = ContractUserRating.joins("INNER JOIN contract_revisions ON contract_revisions.id = contract_user_ratings.contract_revision_id").
                                      where("contract_revision_id IN (?)",contract_revision_ids).
                                      pluck("COUNT(*)")

    prior_years_user_ratings = ContractUserRating.joins("INNER JOIN contract_revisions ON contract_revisions.id = contract_user_ratings.contract_revision_id").
                                where("contract_revision_id IN (?)",contract_revision_ids).
                                pluck("SUM(rating)")

    prior_years_user_ratings[0] = prior_years_user_ratings[0] == nil ? 0 : prior_years_user_ratings[0]

    # prior years lawsuits
    prior_years_lawsuits = ContractRevision.where('id IN (?)',contract_revision_ids).
                          pluck("SUM(lawsuit_score)")

    prior_years_lawsuits[0] = prior_years_lawsuits[0] == nil ? 0 : prior_years_lawsuits[0]

    # current user ratings
    current_user_ratings_count = ContractUserRating.joins("INNER JOIN contract_revisions ON contract_revisions.id = contract_user_ratings.contract_revision_id").
                                      where("contract_revision_id = ?", id).
                                      pluck("COUNT(*)")

    current_user_ratings = ContractUserRating.joins("INNER JOIN contract_revisions ON contract_revisions.id = contract_user_ratings.contract_revision_id").
                              where("contract_revision_id = ?", id).
                              pluck("SUM(rating)")

    current_user_ratings[0] = current_user_ratings[0] == nil ? 0 : current_user_ratings[0]

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

    # current contract revision total ratings including historical user ratinsg, lawsuit, badges
    # excluding historical fairness
    current_year_total = self.rating_1 +
                          self.rating_2 +
                          self.rating_3 +
                          self.rating_4 +
                          self.rating_5 +
                          self.rating_6 +
                          self.rating_7 +
                          self.rating_8 +
                          self.rating_9 +
                          self.rating_10 +
                          self.rating_12 +
                          self.rating_13 +
                          self.rating_14

    # historical fariness ratings
    if (prior_years_count[0] != nil && prior_years_count[0] > 0)
      self.rating_11 = (1.0*(prior_years_total[0] + current_year_total)/(prior_years_count[0]+1))
    else
      self.rating_11 = current_year_total
    end
    self.rating_11 = self.rating_11/9.0

    # total rating for current contract revision
    self.total_rating = current_year_total + self.rating_11

  end
end
