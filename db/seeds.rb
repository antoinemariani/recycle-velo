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
  "l'Etape Vélo" => ["50 Rue Perrin Solliers, 13006 Marseille", "https://www.barelli.fr/img/cms/magasin.jpg"],
  "VÉLO AZUR" => ["37 Rue Goudard, 13005 Marseille", "https://www.shcycles.fr/wa_images/cycles-sh-magasin-velo-electrique-specialiste-artisan_(1).jpg?v=1hnclv9"],
  "Cycle Du Coin & Doctor Bike" => ["Cycle Du Coin & Doctor Bike", "https://rueil-malmaison.cyclable.com/wp-content/uploads/sites/46/2021/08/conseillers-velo-rueil-malmaison-600x430.jpg"],
  "Vélo Sapiens" => ["39 Rue Mazagran, 13001 Marseille", "https://www.weelz.fr/fr/wp-content/uploads/2020/03/velo-randonnee-lille.jpg"],
  "Mimosa Bike Repair" => ["312 Rue d'Endoume, 13007 Marseille", "https://www.weelz.fr/fr/wp-content/uploads/2020/03/velo-cargo-lille-2.jpg"],
  "Bicyclettes La Guibole" => ["41 Rue Saint-Pierre, 13005 Marseille", "https://lvdneng.rosselcdn.net/sites/default/files/dpistyles_v2/ena_16_9_extra_big/2020/12/14/node_907736/49885823/public/2020/12/14/B9725520504Z.1_20201214183845_000%2BGH5H7UOGM.2-0.jpg?itok=z0essfcM1607967536"],
  "Repair And Run Marseille République" => ["31 Rue de la République, 13002 Marseille", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPVGdJOQHtwbPnm8g0Qby1iyUoqoVkoVE7oQ&usqp=CAU"],
  "ZZ VÉLO VINTAGE" => ["4 Rue de la Bibliothèque, 13001 Marseille", "https://bouticycle.com/IMG/jpg/0c3b3635.jpg"],
  "Steedy Bike" => ["17 Rue du Dr Fiolle, 13006 Marseille", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZXGlQSH4luerRohc07f4UUqcuzMit9qrEDg&usqp=CAU"],
  "Atelier 1 Vélo" => ["71 Bd Gillibert, 13009 Marseille", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXaPVffl0KdKG4vCphYmuBCqMoY4i7ogJ5Xg&usqp=CAU"],
  "Road ID" => ["56T Rue d'Italie, 13006 Marseille", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQj5BbvJoKYz2ViKVfMes7mI8u_6qcJfAKezA&usqp=CAU"],
  "BHT BIKE" => ["15 Rue Raymond Teisseire, 13008 Marseille", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRb26x-u3nmOkko1cJOXRBYHWCjV5d6yhAQnQ&usqp=CAU"],
  "Bobine" => ["54 Av. du Prado, 13006 Marseille", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsBPUm9ip0QawIEckyV7ECcmI9lmSNOjmV6A&usqp=CAU"],
  "BeCycles" => ["19 Rue Joël Recher, 13007 Marseille", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqOoLEgNi8hX50lDBL8OegMxDs0wDX2bGhiw&usqp=CAU"],
  "Collectif Vélos en Ville" => ["24 Rue Jean-Pierre-Moustier, 13001 Marseille", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUacbAZf1I-qpbKwYCAam_rDjUS6ERfYfPew&usqp=CAU"]
}

shops.each { |key, value|
  shop = Shop.new(name: key, address: value[0])
  file = URI.open(value[1])
  shop.photo.attach(
    io: file,
    filename: "#{shop.id}.png",
    content_type: "image/png"
  )
  puts "success" if shop.save!
}
