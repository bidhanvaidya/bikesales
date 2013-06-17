class BikeSpecsController < ApplicationController
  # GET /bike_specs
  # GET /bike_specs.json
  def index
    @bikes = BikeSpec.all

    @make_selection = params[:make]
    @model_selection = params[:model]
    @body_selection =  params[:body]
    @price_from_selection = params[:price_from]
    @price_to_selection = params[:price_to]
   

    @bikes=@bikes.where(type: @type_selection ) if !@type_selection.nil?
    @bikes=@bikes.where(make: @make_selection) if !@make_selection.nil?
    @bikes=@bikes.where(model: @model_selection) if !@model_selection.nil?
    @bikes=@bikes.where(color: @color_selection) if !@color_selection.nil?
    @bikes=@bikes.where(:price.gt => @price_from_selection) if !@price_from_selection.nil?
    @bikes=@bikes.where(:price.lt => @price_to_selection) if !@price_to_selection.nil?
    @bikes=@bikes.where(location: @location_selection) if !@location_selection.nil?

    if @body_selection == "Sports"
      @bikes= @bikes.where(body: "Sports")
    end
  if params[:sort] == "price" and params[:direction] == "asc" 
    @bikes = @bikes.asc(:price)
  elsif params[:sort].nil?
    
    @bikes= @bikes.desc(:price)
  elsif params[:sort] == "price" and params[:direction] == "desc"
    @bikes= @bikes.desc(:price)
    
  end
  if params[:sort] == "year" and params[:direction] == "asc" 
    @bikes = @bikes.asc(:year)
  elsif params[:sort] == "year" and params[:direction] == "desc"
    @bikes= @bikes.desc(:year)
    
  end
  @models= @bikes.distinct(:model)

  @makes= @bikes.distinct(:make)
  @bikees=@bikes.paginate(:page => params[:page], :per_page => 2)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bikes }
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
  def change_picture
   bike= BikeSpec.find(params[:id])
   @picture= bike.pictures.find(params[:pic_id])
  
  respond_to do |format|
    print view_context.image_path("test.png")
    format.js
  end
end
end
