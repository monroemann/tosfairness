class Contract < ApplicationRecord
  TYPES = ['website', 'application', 'app with website', 'website with app']

  validates_inclusion_of :contract_type, in: TYPES
  validates_presence_of :contract_type
  validates_presence_of :contract_title

  belongs_to :company
  has_many :contract_revisions, dependent: :destroy, inverse_of: :contract
end
