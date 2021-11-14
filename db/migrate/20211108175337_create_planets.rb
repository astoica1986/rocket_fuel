class CreatePlanets < ActiveRecord::Migration[6.1]
  def change
    create_table :planets do |t|
      t.float :gravitational_accelaration, null: false
      t.string :name, index: { unique: true, name: 'unique_planets' }
      t.boolean :has_fuel, default: false, index: { unique: true, where: 'has_fuel IS TRUE' }
      t.check_constraint 'gravitational_accelaration > 0'

      t.timestamps
    end
  end
end
