json.array!(@contracts) do |contract|
  json.extract! contract, :id, :company_name, :website
end
