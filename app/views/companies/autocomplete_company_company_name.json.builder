json.array!(@companies) do |company|
  json.extract! company, :id, :company_name, :website
end
