# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Company.destroy_all

# File.foreach("db/company.txt") do |company|
#   data = company.split(',')
#   Company.create!(company_name: data[0], website: data[1])
# end

100.times do
  Company.create({
    company_name: Faker::Company.name,
    website: Faker::Internet.url
  })
end
