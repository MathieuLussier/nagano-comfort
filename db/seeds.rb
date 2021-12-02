# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

customers = Customer.create([
                              { name: 'Mathieu Lussier', email: 'Mathieu.test@hotmail.com', phone: '(438) 834 4351' },
                              { name: 'Maxime Verner', email: 'Maxime.test@gmail.com', phone: '(450) 163 3852' }
                            ])

bedroom_types = BedroomType.create([
                                     { name: 'Simple bed' },
                                     { name: 'Double bed' },
                                     { name: 'Executive bedroom' },
                                     { name: 'Presidential suite' }
                                   ])

bedroom_statuses = BedroomStatus.create([
                                          { name: 'In cleaning' },
                                          { name: 'Not available' },
                                          { name: 'Available' }
                                        ])

view_types = ViewType.create([{ name: 'Parking' }, { name: 'Ocean' }])

bedrooms_to_create = []

(0..99).to_a.each do |n|
  n = n.to_s.rjust(2, '0')
  bedrooms_to_create << {
    name: "A1#{n}",
    bedroom_type_id: bedroom_types.sample.id,
    bedroom_status_id: bedroom_statuses.sample.id,
    view_type_id: view_types.sample.id,
    nb_of_beds: rand(1..10),
    price_per_night: rand(95.0..950.50).round(2)
  }
end

bedrooms = Bedroom.create(bedrooms_to_create)

neighbors = []
bedrooms.each do |b|
  neighbors.push b

  if neighbors.length == 3
    neighbors[0].neighbors << neighbors[1]
    neighbors[1].neighbors << neighbors[0]
    neighbors[1].neighbors << neighbors[2]
    neighbors[2].neighbors << neighbors[1]
    neighbors.clear
  end
end

price_variations = PriceVariation.create([
                                           {
                                             name: 'Promo 1 year anniversary',
                                             variation_amount: 0.05,
                                             start_date: Date.parse('2021-11-01'),
                                             end_date: Date.parse('2021-11-30'),
                                             day_of_week: 0,
                                             is_discount: true
                                           },
                                           {
                                             name: 'Partnership discount',
                                             variation_amount: 0.10,
                                             start_date: Date.parse('2021-09-01'),
                                             end_date: nil,
                                             day_of_week: 0,
                                             is_discount: true
                                           },
                                           {
                                             name: 'Friday price',
                                             variation_amount: 0.02,
                                             start_date: Date.parse('2021-09-01'),
                                             end_date: nil,
                                             day_of_week: 5,
                                             is_discount: false
                                           }
                                         ])

reservation_1 = Reservation.create({
                                    customer_id: customers.first.id,
                                    description: 'The client want both bedrooms to be connected together.',
                                    in_date: DateTime.parse('2021-11-06 14:00'),
                                    out_date: nil,
                                    nb_guests: 3,
                                    duration: 2,
                                    bedrooms: [bedrooms[0], bedrooms[1]]
                                  })

reservation_1.price_variations << price_variations.first
reservation_1.price_variations << price_variations.last

transaction_1 = reservation_1.transactions.create({ customer_id: reservation_1.customer.id,
                                                    transaction_date: DateTime.parse('2021-11-10 11:25'),
                                                    total_due: (reservation_1.sub_total.to_f / 2).round(2),
                                                    is_paid: true })
