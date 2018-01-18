class Contract < ApplicationRecord
  include PgSearch

  pg_search_scope :company_search,
                  :against => [:company_name, :website]

  validates :company_name, uniqueness: true, presence: true
  validates :website, uniqueness: true, presence: true
end
