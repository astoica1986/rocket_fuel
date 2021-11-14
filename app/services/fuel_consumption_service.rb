# frozen_string_literal: true

RubyVM::InstructionSequence.compile_option = {
  tailcall_optimization: true,
  trace_instruction: false
}

class FuelConsumptionService
  attr_accessor :mass, :flight_plan

  def self.call(*args)
    new(*args).call
  end

  def initialize(mass = 0, flight_plan = [])
    @mass = mass
    @flight_plan = flight_plan
    validate_flight_plan
    validate_mass
  end

  def call
    calculate_total_fuel(mass, flight_plan) - mass
  end

  private

  def validate_flight_plan
    unless flight_plan.all? { |tuple| tuple.second.is_a?(Float) && tuple.second.positive? }
      raise 'All flight plan tuples must have a positive Float as the second parameter'
    end

    return if flight_plan.all? { |tuple| tuple.first.in? %i[launch land] }

    raise 'All flight plan tuples must have either :launch or :land as the first parameter!'
  end

  def validate_mass
    raise 'The mass value must be a positive number!' unless mass.is_a?(Numeric) && mass.positive?
  end

  def calculate_total_fuel(fuel_mass, current_flight_plan)
    return fuel_mass if current_flight_plan.empty?

    flight_stage, gravity = current_flight_plan.pop
    multiplier_factor, rest_factor = fuel_calculation_factors[flight_stage]
    new_fuel_mass = calculate_total_new_fuel(fuel_mass, gravity, multiplier_factor, rest_factor)
    calculate_total_fuel(fuel_mass + new_fuel_mass, current_flight_plan)
  end

  def calculate_total_new_fuel(new_fuel_mass, gravity, multiplier_factor, rest_factor, acc = 0)
    return acc if new_fuel_mass < rest_factor

    new_fuel_mass = (new_fuel_mass * gravity * multiplier_factor - rest_factor).floor
    acc += [new_fuel_mass, 0].max
    calculate_total_new_fuel(new_fuel_mass, gravity, multiplier_factor, rest_factor, acc)
  end

  def fuel_calculation_factors
    {
      land: [0.033, 42],
      launch: [0.042, 33]
    }
  end
end
