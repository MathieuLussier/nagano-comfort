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
                                     { key: 'chambre_simple_lit', label: 'Chambre simple lit' },
                                     { key: 'chambre_double_lit', label: 'Chambre double lit' },
                                     { key: 'chambre_executive', label: 'Chambre exécutive' },
                                     { key: 'suite_presidentielle', label: 'Suite présidentielle' }
                                   ])

bedroom_statuses = BedroomStatus.create([
                                          { key: 'statut_en_nettoyage', label: 'En nettoyage' },
                                          { key: 'statut_occupe', label: 'Occupé' },
                                          { key: 'statut_reserve', label: 'Réservé' },
                                          { key: 'statut_non_disponible', label: 'Non disponible' },
                                          { key: 'statut_disponible', label: 'Disponible' }
                                        ])

view_types = ViewType.create([{ key: 'view_parking', label: 'Parking' }, { key: 'view_ocean', label: 'Océan' }])

extra_options = ExtraOption.create([
                                     { name: 'Weekend extra price', description: '', is_billable: true, price: 100.00 }
                                   ])

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
                              bedroom_type_id: bedroom_types.find { |x| x.key == 'chambre_double_lit' }.id,
                              bedroom_status_id: bedroom_statuses.find { |x| x.key == 'statut_reserve' }.id,
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

bedrooms[0].neighbors << bedrooms[1]
bedrooms[1].neighbors << bedrooms[0]
bedrooms[1].neighbors << bedrooms[2]
bedrooms[2].neighbors << bedrooms[1]

discounts = Discount.create([
                              { name: 'Promo 1 year anniversary', discount_amount: 0.05, start_date: Date.parse('2021-11-1'), end_date: Date.parse('2021-11-30') },
                              { name: 'Partnership discount', discount_amount: 0.10, start_date: Date.parse('2021-09-1'), end_date: nil }
                            ])

reservation_1 = bedrooms[0].reservations.create({
                                                  customer_id: customers.first.id,
                                                  discount_id: discounts.last.id,
                                                  description: 'The client want both bedrooms to be connected together.',
                                                  in_date: DateTime.parse('2021-11-06 14:00'),
                                                  out_date: '',
                                                  nb_guests: 3,
                                                  duration: 2
                                                })

bedrooms[1].reservations << reservation_1

reservation_1.extra_option_reservation_rels.create({ extra_option_id: extra_options.first.id })

transaction_1 = reservation_1.transactions.create({ customer_id: reservation_1.customer.id, transaction_date: DateTime.parse('2021-11-10 11:25') })
