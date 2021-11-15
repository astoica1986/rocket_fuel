# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FuelConsumptionService, type: :model do
  let(:valid_attributes) do
    [
      { name: 'Earth', gravitational_accelaration: 9.807, has_fuel: true },
      { name: 'Moon', gravitational_accelaration: 1.62 },
      { name: 'Mars', gravitational_accelaration: 3.711 }
    ]
  end

  describe '#call' do
    let(:planets) { Planet.create! valid_attributes }

    let(:apollo11) { [28_801, Planet.parameterize_flight_plan([planets.second.id])] }
    let(:mission_on_mars) { [14_606, Planet.parameterize_flight_plan([planets.third.id])] }
    let(:passenger_ship) { [75_432, Planet.parameterize_flight_plan([planets.second.id, planets.third.id])] }

    let(:invalid_flight_plan_1) { [200, [[:fly, 9.807], [:land, -20]]] }
    let(:invalid_flight_plan_2) { [-200, Planet.parameterize_flight_plan([planets.second.id])] }

    it 'will to calculate the correct amount of fuel with the correct flight plan and mass' do
      expect(described_class.call(*apollo11)).to eq(51_898)
      expect(described_class.call(*mission_on_mars)).to eq(33_388)
      expect(described_class.call(*passenger_ship)).to eq(212_161)
    end

    it 'will raise an error for flight plans with the wrong format' do
      expect { described_class.call(*invalid_flight_plan_1) }.to raise_error('All flight plan tuples must have a positive Float as the second parameter')
    end

    it 'will raise an error for flight plans with an invalid mass' do
      expect { described_class.call(*invalid_flight_plan_2) }.to raise_error('The mass value must be a positive number!')
    end
  end
end
