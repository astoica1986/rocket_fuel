require 'rails_helper'

RSpec.describe Planet, type: :model do
  let(:valid_attributes) do
    [
      { name: 'Earth', gravitational_accelaration: 9.807, has_fuel: true },
      { name: 'Moon', gravitational_accelaration: 1.62 },
      { name: 'Mars', gravitational_accelaration: 3.711 }
    ]
  end

  let(:expected_parameterized_flight_plan) do
    [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 3.711], [:launch, 3.711], [:land, 9.807]]
  end
  describe '#self.parameterize_flight_plan' do
    it 'will return the expected result' do
      planets              = Planet.create! valid_attributes
      flight_plan          = Planet.parameterize_flight_plan([planets.second.id, planets.third.id])
      expect(flight_plan).to eq(expected_parameterized_flight_plan)
    end
  end

  describe '#self.flight_plan' do
    it 'will return the expected result' do
      planets              = Planet.create! valid_attributes
      flight_plan          = Planet.flight_plan([planets.second.id, planets.third.id])
      expect(flight_plan).to eq('Earth, Moon, Mars, Earth')
    end
  end
end
