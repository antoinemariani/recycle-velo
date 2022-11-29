# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

# CREATING 30 USERS
u = 1
30.times do
  puts "Creating user #{u}"
  user = User.new(
    # first_name: Faker::Name.first_name,
    # last_name: Faker::Name.last_name,
    password: Faker::Internet.password(min_length: 8),
  )
  # user.email = Faker::Internet.email(name: "#{user.first_name} #{user.last_name}", separators: ".")
  user.email = Faker::Internet.email
  user.save!
  u += 1
end

# CREATING 60 BIKES RANDOMLY
b = 1
60.times do
  puts "Creating bike #{b}"
  bike = Bike.new(
    name: Faker::Games::SuperMario.character,
    model: Faker::Vehicle.manufacture,
    brand: Faker::Vehicle.make,
    user_id: User.all.sample.id
  )
  bike.save!
  b += 1
end

# CREATING 20 CHAINS
c = 1
20.times do
  puts "Creating chain #{c}"
  chain = Chain.new(
    bike_id: Bike.all.sample.id
  )
  chain.save!
  c += 1
end

# CREATING 20 CHAINS DIAGS
cd = 1
20.times do
  puts "Creating chain diags #{cd}"
  chain_diag = ChainsDiag.new(
    state: Faker::Quote.yoda,
    broken: Faker::Quote.yoda,
    rust: Faker::Quote.yoda,
    derail: Faker::Quote.yoda,
    chainlink: Faker::Quote.yoda,
    chain_id: Chain.all.sample.id
  )
  chain_diag.save!
  cd += 1
end
