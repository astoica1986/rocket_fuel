require 'rails_helper'

RSpec.describe "planets/edit", type: :view do
  before(:each) do
    @planet = assign(:planet, Planet.create!(
      gravitational_accelaration: 1.5,
      name: "MyString",
      has_fuel: false
    ))
  end

  it "renders the edit planet form" do
    render

    assert_select "form[action=?][method=?]", planet_path(@planet), "post" do

      assert_select "input[name=?]", "planet[gravitational_accelaration]"

      assert_select "input[name=?]", "planet[name]"

      assert_select "input[name=?]", "planet[has_fuel]"
    end
  end
end
