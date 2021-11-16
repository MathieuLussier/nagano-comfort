class Bedroom < ActiveRecord::Base
  # after_initialize :default_values
  attr_accessible :name, :bedroom_type_id, :bedroom_status_id, :view_type_id, :price_per_night, :nb_of_beds
  validates_uniqueness_of :name

  validates :name, presence: true, length: { minimum: 3, maximum: 45 }
  validates :bedroom_type_id, presence: true
  validates :bedroom_status_id, presence: true
  validates :view_type_id, presence: true
  validates :price_per_night, presence: true
  validates :nb_of_beds, presence: true

  belongs_to :bedroom_type
  belongs_to :bedroom_status
  belongs_to :view_type

  has_many :bedroom_neighbors
  has_many :neighbors, through: :bedroom_neighbors
  has_many :reservation_bedroom_rel
  has_many :reservations, through: :reservation_bedroom_rel

  class << self
    define_method(:human_attribute_name) do |*args|
      return 'Number of beds' if args[0] == :nb_of_beds

      super(*args)
    end
  end

  private
  # def default_values
  #   self.price_per_night = 0.0
  #   self.nb_of_beds = 0
  # end
end
