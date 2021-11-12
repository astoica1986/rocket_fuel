class CreatePlanets < ActiveRecord::Migration[6.1]
  def change
    create_table :planets do |t|
      t.float :gravitational_accelaration
      t.string :name
      t.boolean :has_fuel

      t.timestamps
    end
  end
end
