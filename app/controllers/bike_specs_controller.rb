class BikeSpecsController < ApplicationController
   before_filter :authenticate_user!, :only => [:new, :edit]
  before_filter :owner, :only => [:new, :create,:edit, :update, :destroy, :delete_picture]
  # GET /bike_specs
  # GET /bike_specs.json
  def index
    last_year= Time.now.year-2
    @bikes = BikeSpec.latest

    @make_selection = params[:make]
    @model_selection = params[:model]
    @body_selection =  params[:body]

    @bikes=@bikes.where(make: @make_selection) if !@make_selection.nil?
    @bikes=@bikes.where(model: @model_selection) if !@model_selection.nil?
   

     @bikes=@bikes.where(body: @body_selection) if !@body_selection.nil?
  if params[:sort] == "price" and params[:direction] == "asc" 
    @bikes = @bikes.asc(:price)
  elsif params[:sort] == "price" and params[:direction] == "desc"
    @bikes= @bikes.desc(:price)
    
  elsif params[:sort] == "year" and params[:direction] == "asc" 
    @bikes = @bikes.asc(:year)
  elsif params[:sort] == "year" and params[:direction] == "desc"
    @bikes= @bikes.desc(:year)
    
  else
    @bikes = @bikes.desc(:year, :updated)
  end
  @models= @bikes.distinct(:model)
  @bodies= @bikes.distinct(:body)
  
  @makes= @bikes.distinct(:make)
  @bikees=@bikes.paginate(:page => params[:page], :per_page => 10)
  set_meta_tags :title => 'Search for New Bikes, get prices, Specs,  and compare',
              :description => "New Bike for sale, to the nepali public, bikes bechnu, specs, bikes.bechnu.com"+
              [@models, @makes].reject(&:empty?).join(', '),
              :keywords => "Bike, sale, Specs, Specifiction, nepal, bikes bechnu, bikes.bechnu.com,"+[@models, @makes].reject(&:empty?).join(', '),
              :canonical => bikes_url(make:params[:make], model: params[:model])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bikes }
    end
    
  end

  # GET /bike_specs/1
  # GET /bike_specs/1.json
  def show
    @bike_spec = BikeSpec.find(params[:id])
    @makers_bike = BikeSpec.latest.where(make: @bike_spec.make).desc(:year, :updated).limit(3)
    set_meta_tags :title => [@bike_spec.year.to_s,@bike_spec.make,@bike_spec.model,@bike_spec.variant].reject(&:empty?).join(' '),
              :description => "New Bike for sale, to the nepali public, specs, "+
              [@bike_spec.year.to_s,@bike_spec.make,@bike_spec.model,@bike_spec.variant, @bike_spec.body, @bike_spec.price.to_s].reject(&:empty?).join(' '),
              :keywords => "Bike for sale nepal "+[@bike_spec.year.to_s,@bike_spec.make,@bike_spec.model,@bike_spec.variant,  @bike_spec.body].reject(&:empty?).join(', '),
              :canonical => bike_url(@bike_spec)
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
    @bike_spec.updated = Time.now
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
    @bike_spec.updated = Time.now
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
    format.js
  end
end

def delete_picture
     bike= BikeSpec.find(params[:id])
     picture= bike.pictures.find(params[:picture_id])
     picture.file= nil
     picture.save
     picture.delete
     respond_to do |format|
      format.js
     
    end
     
  end

def showroom
  @bikes = BikeSpec.latest.desc(:year)
  @latest_bike = @bikes.desc(:year, :updated).limit(3)
  @models= @bikes.distinct(:model)

  @makes= @bikes.distinct(:make)
  set_meta_tags :title => 'Search New Bikes for sale in Nepal, get their specs, price',
              :description => "Search  new for sale, Find new bike for sale &amp; 
    new bike dealer specials at bikes.bechnu.com - Nepal's newest bike website.",
              :keywords => 'Bike, sale, new bike, specs',
              :canonical => "bikes.bechnu.com/showroom"
  
end

  def search
    make=nil
    model=nil
    body=nil
    make=params[:make] if !params[:make].empty?
    model=params[:model] if !params[:model].empty?
    body=params[:body] if params[:body]!= 'Any Type'

    redirect_to bike_specs_path(make: make, model: model, body: body)

  end
  def change_model
    
  
    @bikes = BikeSpec.latest.where(make: params[:make])
    @models= @bikes.distinct(:model)
    respond_to do |format|
      format.js
    end
  end
  def copy_new
    @bike_spec = BikeSpec.new(params[:bike_spec])
    @bike_spec.updated = Time.now
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
  private
  def owner
    if current_user == User.first || current_user.email == "bidhanvaidya@gmail.com"
      return true
    else
      redirect_to bike_specs_path
    end
  end


end
