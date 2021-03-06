class PlanetsController < ApplicationController
  before_action :set_planet, only: %i[ show edit update destroy]

  # GET /planets or /planets.json
  def index
    @planets = Planet.all
    @planets_flight_ids = JSON.parse(params[:planets_flight_ids] || '[]')
    @flight_plan = Planet.flight_plan(@planets_flight_ids)
    @parameterized_flight_plan = Planet.parameterize_flight_plan(@planets_flight_ids)
    @mass = params[:mass].to_i || 0
    @fuel_consumption = calculate_fuel_consumption
  end

  # GET /planets/1 or /planets/1.json
  def show
  end

  # GET /planets/new
  def new
    @planet = Planet.new
  end

  # GET /planets/1/edit
  def edit
  end

  # POST /planets or /planets.json
  def create
    @planet = Planet.new(planet_params)

    respond_to do |format|
      if @planet.save
        format.html { redirect_to @planet, notice: 'Planet was successfully created.' }
        format.json { render :show, status: :created, location: @planet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @planet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /planets/1 or /planets/1.json
  def update
    respond_to do |format|
      if @planet.update(planet_params)
        format.html { redirect_to @planet, notice: 'Planet was successfully updated.' }
        format.json { render :show, status: :ok, location: @planet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @planet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /planets/1 or /planets/1.json
  def destroy
    @planet.destroy
    respond_to do |format|
      format.html { redirect_to planets_url, notice: 'Planet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_planet
    @planet = Planet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def planet_params
    params.require(:planet).permit(:gravitational_accelaration, :name, :has_fuel)
  end

  def calculate_fuel_consumption
    return 0 if @mass <= 0 || @flight_plan.blank?

    FuelConsumptionService.call(@mass, @parameterized_flight_plan.dup)
  end
end
