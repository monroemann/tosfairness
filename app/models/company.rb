class Company < ApplicationRecord
  attr_accessor :request_note, :tos_flag

  has_many :contracts, dependent: :destroy
  has_many :contract_revisions, through: :contracts
  has_many :update_requests, dependent: :destroy
  has_many :votes

  validates :company_name, uniqueness: true, presence: true
  validates :website, uniqueness: true, allow_blank: true

  scope :name_like, -> (name) { where("company_name ilike ? or companies.website ilike ?", name, name) }

  before_save :downcase_url

  def downcase_url
    self.website.downcase!
  end

  def self.with_contract_review_status(*ids)
    query =
      "SELECT c.* request_count, contract_count
      FROM
      (SELECT  companies.*, case when u.status = 'Requested' then 1 else 0 end AS request_count,
      SUM(case when contract_revisions.status = 'Completed' then 1
      else 0 end) AS contract_count FROM companies
      LEFT OUTER JOIN contracts ON contracts.company_id = companies.id
      LEFT OUTER JOIN contract_revisions ON contract_revisions.contract_id = contracts.id
      LEFT OUTER JOIN
        (SELECT DISTINCT t.id, t.status
        from
        (
            SELECT companies.id, update_requests.status, update_requests.created_at
            FROM companies
            LEFT OUTER JOIN update_requests ON update_requests.company_id = companies.id
            WHERE update_requests.status = 'Requested'
            ORDER BY update_requests.created_at DESC
        ) t
        ) u ON companies.id = u.id
      GROUP BY companies.id, u.status
      ) c
      WHERE c.id IN (?)
      ORDER BY c.company_name"

    self.find_by_sql([query,ids[0]])
  end

end
