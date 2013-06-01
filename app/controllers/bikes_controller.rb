class BikesController < ApplicationController
  # GET /bikes
  # GET /bikes.json
   before_filter :authenticate_user!, :only => [:edit, :update, :destroy]

  def index
    
    @bikes = Bike.all

    b= Bike.full_text_search(params[:search]).size
    print b
    @type_selection = params[:type]
    @make_selection = params[:make]
    @model_selection = params[:model]
    @color_selection = params[:color]
    @body_selection =  params[:body]
    @bikes=@bikes.where(type: @type_selection ) if !@type_selection.nil?
    @bikes=@bikes.make(@make_selection) if !@make_selection.nil?
    @bikes=@bikes.where(model: @model_selection) if !@model_selection.nil?

    @bikes=@bikes.where(color: @color_selection) if !@color_selection.nil?
    if @body_selection == "Sports"
      @bikes= @bikes.where(body: "sports")
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
  @types= @bikes.distinct(:type)
  @models= @bikes.distinct(:model)

  @makes= @bikes.distinct(:make)
  @colors= @bikes.distinct(:color)
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bikes }
    end
  end

  # GET /bikes/1
  # GET /bikes/1.json
  def show
    @bike = Bike.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bike }
    end
  end

  # GET /bikes/new
  # GET /bikes/new.json
  def new
    @bike = Bike.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bike }
    end
  end

  # GET /bikes/1/edit
  def edit
    @bike = Bike.find(params[:id])
  end

  # POST /bikes
  # POST /bikes.json
  def create
    @bike = Bike.new(params[:bike])
     bike_spec= BikeSpec.where(variant: params[:bike][:variant]).first
    @bike.bike_spec_id = bike_spec.id
    @bike.body = bike_spec.body
    @bike.user_id = current_user.id
    respond_to do |format|
      if @bike.save
        format.html { redirect_to @bike, notice: 'Bike was successfully created.' }
        format.json { render json: @bike, status: :created, location: @bike }
      else
        format.html { render action: "new" }
        format.json { render json: @bike.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bikes/1
  # PUT /bikes/1.json
  def update
    @bike = Bike.find(params[:id])
    bike_spec= BikeSpec.where(variant: params[:bike][:variant]).first
    @bike.bike_spec_id = bike_spec.id
    @bike.body = bike_spec.body

    @bike.user_id = current_user.id

    respond_to do |format|
      if @bike.update_attributes(params[:bike])
        format.html { redirect_to @bike, notice: 'Bike was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bike.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bikes/1
  # DELETE /bikes/1.json
  def destroy
    @bike = Bike.find(params[:id])
    @bike.destroy

    respond_to do |format|
      format.html { redirect_to bikes_url }
      format.json { head :no_content }
    end
  end

  def change_model
    @bikes=BikeSpec.where(make: params[:make]).distinct(:model)
    print "hel"
    respond_to do |format|
    format.js
  end
  end
    def change_variant
    @bikes=BikeSpec.where(model: params[:model]).distinct(:variant)
    print "hel"
    respond_to do |format|
    format.js
  end
  end
end
