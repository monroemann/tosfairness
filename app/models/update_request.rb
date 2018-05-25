class UpdateRequest < ApplicationRecord
  belongs_to :company

  STATUS = ["Requested", "Completed"]
end
