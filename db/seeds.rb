# frozen_string_literal: true

planets = [
  { name: 'Earth', gravitational_accelaration: 9.807, has_fuel: true },
  { name: 'Moon', gravitational_accelaration: 1.62 },
  { name: 'Mars', gravitational_accelaration: 3.711 }
]

Planet.create! planets
