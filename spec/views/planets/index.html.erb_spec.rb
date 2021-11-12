require 'rails_helper'

RSpec.describe "planets/index", type: :view do
  before(:each) do
    assign(:planets, [
      Planet.create!(
        gravitational_accelaration: 2.5,
        name: "Name",
        has_fuel: false
      ),
      Planet.create!(
        gravitational_accelaration: 2.5,
        name: "Name",
        has_fuel: false
      )
    ])
  end

  it "renders a list of planets" do
    render
    assert_select "tr>td", text: 2.5.to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
  end
end
