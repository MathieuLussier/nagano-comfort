class Bedroom < ActiveRecord::Base
  attr_accessible :name, :bedroom_type_id, :bedroom_status_id,
                  :view_type_id, :price_per_night, :nb_of_beds,
                  :view_type, :bedroom_type, :bedroom_status,
                  :neighbors, :bedroom_neighbors

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
      return 'Number of bed(s)' if args[0] == :nb_of_beds

      super(*args)
    end
  end

  def check_if_available?(start_date, end_date)
    self.reservations.each do |reservation|
      r_start_date = reservation.in_date.to_date
      r_end_date = r_start_date + (reservation.duration.to_i).day
      return false if start_date < r_end_date && r_start_date < end_date
    end

    true
  end

  # scope :available, -> (start_date, end_date) { select { |bed| bed.check_if_available?(start_date, end_date) } }
  # scope :available, lambda { |start_date, end_date| joins(:reservations).where('? > reservations.expected_end_date AND reservations.in_date > ?', start_date, end_date) }
  # scope :available, lambda {|start_date, end_date| joins(:reservations).where.not('? <= reservations.expected_end_date AND reservations.in_date <= ?', start_date, end_date) }
  # scope :available, lambda {|start_date, end_date| joins(:reservations).where('reservations.expected_end_date <= ?', start_date) }

  after_save :ensure_neighbors_both_ways, on: [ :create, :update ]

  def ensure_neighbors_both_ways
    neighbors.each do |neighbor|
      neighbor_ids = neighbor.neighbors.map(&:id)
      neighbor.neighbors << self unless neighbor_ids.include? id
    end
  end
end
