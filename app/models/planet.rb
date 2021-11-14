# frozen_string_literal: true

class Planet < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :gravitational_accelaration, presence: true, numericality: { greater_than: 0.0 }
  validates :has_fuel, uniqueness: true, if: :has_fuel

  scope :with_fuel, -> { where(has_fuel: true).first }

  def self.parameterize_flight_plan(planets_flight_ids)
    planet_with_fuel = with_fuel
    parameterized_flight_plan = []
    flight_plan = find(planets_flight_ids)
    planets_flight_ids.map { |x| flight_plan.detect { |p| p.id == x } }.each do |planet|
      parameterized_flight_plan << [:land, planet.gravitational_accelaration]
      parameterized_flight_plan << [:launch, planet.gravitational_accelaration]
    end
    parameterized_flight_plan.prepend([:launch, planet_with_fuel.gravitational_accelaration])
    parameterized_flight_plan.append([:land, planet_with_fuel.gravitational_accelaration])
    parameterized_flight_plan
  end

  def self.flight_plan(planets_flight_ids)
    planet_with_fuel = with_fuel.name
    flight_plan = find(planets_flight_ids)
    full_flight_plan = planets_flight_ids.map { |x| flight_plan.detect { |p| p.id == x }.name }
    full_flight_plan.prepend(planet_with_fuel)
    full_flight_plan.append(planet_with_fuel)
    full_flight_plan.join(', ')
  end
end
