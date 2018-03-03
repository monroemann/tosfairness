class UserLogging < ApplicationRecord
  belongs_to :user
  belongs_to :contract_revision
end
