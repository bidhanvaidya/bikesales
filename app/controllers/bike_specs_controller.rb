class BikeSpecsController < ApplicationController
  # GET /bike_specs
  # GET /bike_specs.json
  def index
    @bike_specs = BikeSpec.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bike_specs }
    end
  end

  # GET /bike_specs/1
  # GET /bike_specs/1.json
  def show
    @bike_spec = BikeSpec.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bike_spec }
    end
  end

  # GET /bike_specs/new
  # GET /bike_specs/new.json
  def new
    @bike_spec = BikeSpec.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bike_spec }
    end
  end

  # GET /bike_specs/1/edit
  def edit
    @bike_spec = BikeSpec.find(params[:id])
  end

  # POST /bike_specs
  # POST /bike_specs.json
  def create
    @bike_spec = BikeSpec.new(params[:bike_spec])

    respond_to do |format|
      if @bike_spec.save
        format.html { redirect_to @bike_spec, notice: 'Bike spec was successfully created.' }
        format.json { render json: @bike_spec, status: :created, location: @bike_spec }
      else
        format.html { render action: "new" }
        format.json { render json: @bike_spec.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bike_specs/1
  # PUT /bike_specs/1.json
  def update
    @bike_spec = BikeSpec.find(params[:id])

    respond_to do |format|
      if @bike_spec.update_attributes(params[:bike_spec])
        format.html { redirect_to @bike_spec, notice: 'Bike spec was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bike_spec.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bike_specs/1
  # DELETE /bike_specs/1.json
  def destroy
    @bike_spec = BikeSpec.find(params[:id])
    @bike_spec.destroy

    respond_to do |format|
      format.html { redirect_to bike_specs_url }
      format.json { head :no_content }
    end
  end
end
