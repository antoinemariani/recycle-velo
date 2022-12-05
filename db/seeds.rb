# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

# ChainsDiag.destroy_all
# Chain.destroy_all
# Bike.destroy_all
# User.destroy_all

# # CREATING 30 USERS
# u = 1
# 30.times do
#   puts "Creating user #{u}"
#   user = User.new(
#     # first_name: Faker::Name.first_name,
#     # last_name: Faker::Name.last_name,
#     password: Faker::Internet.password(min_length: 8),
#   )
#   # user.email = Faker::Internet.email(name: "#{user.first_name} #{user.last_name}", separators: ".")
#   user.email = Faker::Internet.email
#   user.save!
#   u += 1
# end

# # CREATING 60 BIKES RANDOMLY
# b = 1
# 60.times do
#   puts "Creating bike #{b}"
#   bike = Bike.new(
#     name: Faker::Games::SuperMario.character,
#     model: Faker::Vehicle.manufacture,
#     brand: Faker::Vehicle.make,
#     user: User.all.sample
#   )
#   bike.save!
#   b += 1
# end

# # CREATING 20 CHAINS
# c = 1
# 20.times do
#   puts "Creating chain #{c}"
#   chain = Chain.new(
#     state: Faker::Quote.jack_handey,
#     broken: Faker::Boolean.boolean,
#     rust: Faker::Boolean.boolean,
#     derail: Faker::Boolean.boolean,
#     chainlink: Faker::Quote.jack_handey,
#     bike: Bike.all.sample
#   )
#   chain.save!
#   c += 1
# end

# # CREATING 20 CHAINS DIAGS
# cd = 1
# 20.times do
#   puts "Creating chain diags #{cd}"
#   chain_diag = ChainsDiag.new(
#     state: Faker::Quote.yoda,
#     broken: Faker::Quote.yoda,
#     rust: Faker::Quote.yoda,
#     derail: Faker::Quote.yoda,
#     chainlink: Faker::Quote.yoda,
#     chain_id: Chain.all.sample.id
#   )
#   chain_diag.save!
#   cd += 1
# end


###################### SEEDING REAL BIKES WORKSHOPS IN MARSEILLE #######################

shops = {
  "l'Etape Vélo" => "50 Rue Perrin Solliers, 13006 Marseille",
  "VÉLO AZUR" => "37 Rue Goudard, 13005 Marseille",
  "Cycle Du Coin & Doctor Bike" => "Cycle Du Coin & Doctor Bike",
  "Vélo Sapiens" => "39 Rue Mazagran, 13001 Marseille",
  "Mimosa Bike Repair" => "312 Rue d'Endoume, 13007 Marseille",
  "Bicyclettes La Guibole" => "41 Rue Saint-Pierre, 13005 Marseille",
  "Repair And Run Marseille République" => "31 Rue de la République, 13002 Marseille",
  "ZZ VÉLO VINTAGE" => "4 Rue de la Bibliothèque, 13001 Marseille",
  "Steedy Bike" => "17 Rue du Dr Fiolle, 13006 Marseille",
  "Atelier 1 Vélo" => "71 Bd Gillibert, 13009 Marseille",
  "Road ID" => "56T Rue d'Italie, 13006 Marseille",
  "BHT BIKE" => "15 Rue Raymond Teisseire, 13008 Marseille",
  "Bobine" => "54 Av. du Prado, 13006 Marseille",
  "BeCycles" => "19 Rue Joël Recher, 13007 Marseille",
  "Collectif Vélos en Ville" => "24 Rue Jean-Pierre-Moustier, 13001 Marseille"
}

shops.each { |key, value| Shop.create(name: key, address: value) }
