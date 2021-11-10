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
                                     { key: 'bedroom_simple_bed', label: 'Simple bed' },
                                     { key: 'bedroom_double_bed', label: 'Double bed' },
                                     { key: 'bedroom_executive', label: 'Executive bedroom' },
                                     { key: 'presidential_suite', label: 'Presidential suite' }
                                   ])

bedroom_statuses = BedroomStatus.create([
                                          { key: 'status_in_cleaning', label: 'In cleaning' },
                                          { key: 'status_occupied', label: 'Occupied' },
                                          { key: 'status_reserved', label: 'Reserved' },
                                          { key: 'status_not_available', label: 'Not available' },
                                          { key: 'status_available', label: 'Available' }
                                        ])

view_types = ViewType.create([{ key: 'view_parking', label: 'Parking' }, { key: 'view_ocean', label: 'Ocean' }])

bedrooms = Bedroom.create([
                            {
                              name: 'A100',
                              bedroom_type_id: bedroom_types.first.id,
                              bedroom_status_id: bedroom_statuses.first.id,
                              view_type_id: view_types.first.id,
                              nb_of_beds: 2,
                              price_per_night: 355.50
                            },
                            {
                              name: 'A101',
                              bedroom_type_id: bedroom_types.find { |x| x.key == 'bedroom_double_bed' }.id,
                              bedroom_status_id: bedroom_statuses.find { |x| x.key == 'status_reserved' }.id,
                              view_type_id: view_types.find { |x| x.key == 'view_ocean' }.id,
                              nb_of_beds: 1,
                              price_per_night: 410.75
                            },
                            {
                              name: 'A102',
                              bedroom_type_id: bedroom_types.last.id,
                              bedroom_status_id: bedroom_statuses.last.id,
                              view_type_id: view_types.last.id,
                              nb_of_beds: 4,
                              price_per_night: 672.25
                            }
                          ])

bedrooms_to_create = []

(3..99).to_a.each do |n|
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

Bedroom.create(bedrooms_to_create)

bedrooms[0].neighbors << bedrooms[1]
bedrooms[1].neighbors << bedrooms[0]
bedrooms[1].neighbors << bedrooms[2]
bedrooms[2].neighbors << bedrooms[1]

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

reservation_1 = bedrooms[0].reservations.create({
                                                  customer_id: customers.first.id,
                                                  description: 'The client want both bedrooms to be connected together.',
                                                  in_date: DateTime.parse('2021-11-06 14:00'),
                                                  out_date: nil,
                                                  nb_guests: 3,
                                                  duration: 2
                                                })

bedrooms[1].reservations << reservation_1

reservation_1.price_variations << price_variations.first
reservation_1.price_variations << price_variations.last

transaction_1 = reservation_1.transactions.create({ customer_id: reservation_1.customer.id, transaction_date: DateTime.parse('2021-11-10 11:25') })
