class Company < ApplicationRecord
  has_many :contracts, dependent: :destroy
  has_many :contract_revisions, through: :contracts

  validates :company_name, uniqueness: true, presence: true
  validates :website, uniqueness: true

  scope :name_like, -> (name) { where("company_name ilike ? or companies.website ilike ?", name, name) }

  before_save :downcase_url

  def downcase_url
    self.website.downcase!
  end
end
