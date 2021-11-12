require 'rails_helper'

RSpec.describe "planets/new", type: :view do
  before(:each) do
    assign(:planet, Planet.new(
      gravitational_accelaration: 1.5,
      name: "MyString",
      has_fuel: false
    ))
  end

  it "renders new planet form" do
    render

    assert_select "form[action=?][method=?]", planets_path, "post" do

      assert_select "input[name=?]", "planet[gravitational_accelaration]"

      assert_select "input[name=?]", "planet[name]"

      assert_select "input[name=?]", "planet[has_fuel]"
    end
  end
end
