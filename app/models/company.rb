class Company < ApplicationRecord
  has_many :contracts, dependent: :destroy

  validates :company_name, uniqueness: true, presence: true
  validates :website, uniqueness: true

  scope :name_like, -> (name) { where("company_name ilike ? or website ilike ?", name, name) }
end
