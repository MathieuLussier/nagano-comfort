class Reservation < ActiveRecord::Base
  attr_accessible :customer, :customer_id, :description,
                  :in_date, :out_date, :nb_guests, :duration,
                  :bedrooms, :sub_total, :price_variations, :expected_end_date

  validates :customer_id, presence: true
  validates :in_date, presence: true
  validates :duration, numericality: { other_than: 0 }
  validates :nb_guests, numericality: { other_than: 0 }

  belongs_to :customer

  has_many :reservation_bedroom_rels
  # has_many :bedrooms, through: :reservation_bedroom_rels, before_add: [:check_if_bedroom_available]
  has_many :bedrooms, through: :reservation_bedroom_rels, before_add: [:check_if_bedroom_available]
  has_many :transactions, class_name: 'Transaction'
  has_many :reservation_price_variation_rels
  has_many :price_variations, through: :reservation_price_variation_rels

  class << self
    define_method(:human_attribute_name) do |*args|
      return 'Number of guest(s)' if args[0] == :nb_guests

      super(*args)
    end
  end

  def check_if_bedroom_available(bedroom)
    r_start_date = self.in_date.to_date
    r_end_date = r_start_date + (self.duration.to_i).day
    unless bedroom.check_if_available?(r_start_date, r_end_date)
      errors.add("Bedroom #{bedroom.name}", "can't be added because he is not available during date range")
      # throw(:abort)
    end
  end

  validate :customer_already_have_transaction, on: :update
  validate :test_to_make_sure
  # validate :check_price_variation_can_apply

  def customer_already_have_transaction
    if self.transactions.any? && customer_id_changed?
      errors.add(:customer, "can't be change because this customer already have active transaction(s) link to this reservation")
    end
  end

  def test_to_make_sure
    self.bedrooms.each do |bedroom|
      self.check_if_bedroom_available(bedroom)
    end
  end

  # @TODO make sure we can still add the price variation dependant on the duration included instead of just the start date
  # def check_price_variation_can_apply
  #   self.price_variations.each do |price_variation|
  #     unless price_variation[:end_date].present?
  #       if self.in_date.to_date <= price_variation.start_date
  #         return errors.add("Price variation #{price_variation.name}", "can't be applied")
  #       end
  #     end
  #
  #     if price_variation[:end_date].present?
  #       unless (price_variation.start_date..price_variation.end_date).cover?(self.in_date.to_date)
  #         return errors.add("Price variation #{price_variation.name}", "can't be applied")
  #       end
  #     end
  #   end
  # end

  after_create :add_available_price_variation
  before_save :compute_sub_total, :compute_expected_end_date, on: [:create, :update]

  def get_day_of_week_result(price_variation)
    if price_variation.day_of_week > 0
      start_date = self.in_date.to_date
      end_date = start_date + (self.duration.to_i).day
      (start_date..end_date).to_a.select { |k| [price_variation.day_of_week.to_i - 1].include?(k.wday) }.length
    else
      nil
    end
  end

  def add_available_price_variation
    PriceVariation.all.each do |price_variation|
      if price_variation.day_of_week > 0
        nb_days_applied = self.get_day_of_week_result(price_variation)
        if nb_days_applied > 0
          self.price_variations << price_variation
        end
      else
        if self.in_date.to_date >= price_variation.start_date
          self.price_variations << price_variation
        end
      end
    end
  end

  def compute_expected_end_date
    start_date = self.in_date.to_date
    self.expected_end_date = start_date + (self.duration.to_i).day
  end

  def compute_sub_total
    self.sub_total = 0.0

    self.bedrooms.each do |bedroom|
      self.sub_total += self.calculate_bedroom_price(bedroom)
    end
  end

  def calculate_bedroom_price(bedroom)
    total = self.duration.to_i * bedroom.price_per_night.to_f

    self.price_variations.each do |price_variation|
      total += self.apply_price_variation(bedroom, price_variation)
    end

    total
  end

  def apply_price_variation(bedroom, price_variation)
    variation_total = 0.0
    bedroom_total = self.duration.to_i * bedroom.price_per_night.to_f
    amount = self.duration.to_i

    if price_variation.day_of_week > 0
      nb_days_applied = self.get_day_of_week_result(price_variation)
      new_bedroom_price = bedroom.price_per_night.to_f
      if price_variation.is_discount?
        new_bedroom_price -= price_variation.variation_amount.to_f * bedroom.price_per_night.to_f
      else
        new_bedroom_price += price_variation.variation_amount.to_f * bedroom.price_per_night.to_f
      end

      new_total = nb_days_applied * new_bedroom_price
      amount -= nb_days_applied
      new_total += amount * bedroom.price_per_night.to_f

      if new_total > bedroom_total
        variation_total = new_total - bedroom_total
      else
        variation_total = -(bedroom_total - new_total)
      end
    else
      if price_variation.is_discount?
        variation_total = -(price_variation.variation_amount.to_f * bedroom_total)
      else
        variation_total = price_variation.variation_amount.to_f * bedroom_total
      end
    end
    
    variation_total
  end
end
