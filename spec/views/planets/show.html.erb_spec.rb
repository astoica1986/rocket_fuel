require 'rails_helper'

RSpec.describe "planets/show", type: :view do
  before(:each) do
    @planet = assign(:planet, Planet.create!(
      gravitational_accelaration: 2.5,
      name: "Name",
      has_fuel: false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/false/)
  end
end
