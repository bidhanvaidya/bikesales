class BikeSpecsController < ApplicationController
  require 'nokogiri'
require 'open-uri'
   before_filter :authenticate_user!, :only => [:new, :edit]
  before_filter :owner, :only => [:new, :create,:edit, :update, :destroy, :delete_picture]
 include BikeSpecsHelper
  # GET /bike_specs
  # GET /bike_specs.json
  def index

    last_year= Time.now.year-2
    if current_user
        if current_user.email=="admin@bikes.bechnu.com"
            @bikes=BikeSpec.all
        end
    else    
        @bikes = BikeSpec.latest.with_price.only(:model, :price, :make, :year, :variant, :displacement, 
            :body, :max_power, :max_torque, :fuel_consumption_city,:pictures, :fuel_consumption_highway, :top_speed).all
    end
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
  @models= @bikes.distinct(:model).sort
  @bodies= @bikes.distinct(:body).sort
  
  @makes= @bikes.distinct(:make).sort
  @bikees=@bikes.paginate(:page => params[:page], :per_page => 10)
  set_meta_tags :title => 'Search for New Bikes, get prices, Specs,  and compare',
              :description => "New Bike for sale, to the nepali public, bikes bechnu, specs, bikes.bechnu.com"+
              [@models, @makes].reject(&:nil?).reject(&:empty?).join(', '),
              :keywords => "Bike, sale, Specs, Specifiction, nepal, bikes bechnu, bikes.bechnu.com,"+[@models, @makes].reject(&:nil?).reject(&:empty?).join(', '),
              :canonical => bike_specs_url(make:params[:make], model: params[:model])
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
    set_meta_tags :title => [@bike_spec.year.to_s,@bike_spec.make,@bike_spec.model,@bike_spec.variant].reject(&:nil?).reject(&:empty?).join(' '),
              :description => "New Bike for sale, to the nepali public, specs, "+
              [@bike_spec.year.to_s,@bike_spec.make,@bike_spec.model,@bike_spec.variant, @bike_spec.body, @bike_spec.price.to_s].reject(&:nil?).reject(&:empty?).join(' '),
              :keywords => "Bike for sale nepal "+[@bike_spec.year.to_s,@bike_spec.make,@bike_spec.model,@bike_spec.variant,  @bike_spec.body].reject(&:nil?).reject(&:empty?).join(', '),
              :canonical => bike_spec_url(@bike_spec)
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
   
    if !params[:bike_spec][:link].empty?
      doc = Nokogiri::HTML(open(params[:bike_spec][:link]))
      start = false
      doc.css('table tr td table tr td table tr').each do |link|
        fiel= link.content.to_s
        if fiel.include? "Displacement"
          start=true
        end
        if start

          if fiel.include? "Sell or buy used bikes"
            break
          end
          if fiel.include? ":"
            result= fiel.split(":")

            if result[0]== "Displacement"
            @bike_spec.displacement= result[1]
            end
            if result[0]== "Engine type"
            @bike_spec.engine= result[1]
            end
            if result[0]== "Power"
            @bike_spec.max_power= result[1]
            end            
            if result[0]== "Torque"
            @bike_spec.max_torque= result[1]
            end            
            if result[0]== "Compression"
            @bike_spec.bore= result[1]
            end
            if result[0]== "Bore x stroke"
            @bike_spec.stroke= result[1]
            end
            if result[0]== "Valves per cylinders"
            @bike_spec.valve_per_cylinder= result[1]
            end
            if result[0]== "Fuel system"
            @bike_spec.no_of_cylinders= result[1]
            end
            if result[0]== "Fuel control"
            @bike_spec.fuel_control= result[1]
            end
            if result[0]== "Ignition"
            @bike_spec.ignition= result[1]
            end
            if result[0]== "Lubrication system"
            @bike_spec.lubrication= result[1]
            end
            if result[0]== "Cooling system"
            @bike_spec.cooling_type= result[1]
            end
            if result[0]== "Gearbox"
            @bike_spec.transmission= result[1]
            end
            if result[0]== "Transmission type,final drive"
            @bike_spec.transmission_type= result[1]
            end
            if result[0]== "Clutch"
            @bike_spec.clutch= result[1]
            end
            if result[0]== "Exhaust system"
            @bike_spec.exhaust= result[1]
            end
            if result[0]== "Frame type"
            @bike_spec.chassis_type= result[1]
            end
            if result[0]== "Rake (fork angle)"
            @bike_spec.rake= result[1]
            end
            if result[0]== "Trail"
            @bike_spec.trail= result[1]
            end
            if result[0]== "Front suspension"
            @bike_spec.suspension_front= result[1]
            end
            if result[0]== "Front suspension travel"
            @bike_spec.fs_travel= result[1]
            end
            if result[0]== "Rear suspension"
            @bike_spec.suspension_rear= result[1]
            end
            if result[0]== "Rear suspension travel"
            @bike_spec.rs_travel= result[1]
            end
            if result[0]== "Front tyre dimensions"
            @bike_spec.wheel_type= result[1]
            end
            if result[0]== "Rear tyre dimensions"
            @bike_spec.wheel_size= result[1]
            end
            if result[0]== "Front brakes"
            @bike_spec.brakes_front= result[1]
            end
            if result[0]== "Front brakes diameter"
            @bike_spec.fb_diameter= result[1]
            end
            if result[0]== "Rear brakes"
            @bike_spec.brakes_rear= result[1]
            end
            if result[0]== "Rear brakes diameter"
            @bike_spec.rb_diameter= result[1]
            end
            if result[0]== "Dry weight"
            @bike_spec.weight= result[1]
            end
            if result[0]== "Weight incl. oil, gas, etc"
            @bike_spec.g_weight= result[1]
            end
            if result[0]== "Power/weight ratio"
            @bike_spec.pw_ratio= result[1]
            end
            if result[0]== "Seat height"
            @bike_spec.seat_height= result[1]
            end
            if result[0]== "Overall height"
            @bike_spec.height= result[1]
            end
            if result[0]== "Overall length"
            @bike_spec.length= result[1]
            end
            if result[0]== "Overall width"
            @bike_spec.width= result[1]
            end
            if result[0]== "Ground clearance"
            @bike_spec.ground_clearance= result[1]
            end
            if result[0]== "Wheelbase"
            @bike_spec.wheelbase= result[1]
            end
            if result[0]== "Fuel capacity"
            @bike_spec.fuel_tank= result[1]
            end
            if result[0]== "Wheels"
            @bike_spec.wheel= result[1]
            end
            if result[0]== "Engine details"
            @bike_spec.engine_detail = result[1]
            end
            if result[0]== "Greenhouse gases"
            @bike_spec.greenhouse  = result[1]
            end
            if result[0]== "Driveline"
            @bike_spec.driveline  = result[1]
            end
            if result[0]== "Fuel consumption"
            @bike_spec.fuel_consumption  = result[1]
            end
            if result[0]== "Emission details"
            @bike_spec.emmission  = result[1]
            end
            if result[0]== "Electrical"
            @bike_spec.electrical  = result[1]
            end
            if result[0]== "Starter"
            @bike_spec.starter  = result[1]
            end
            if result[0]== "Instruments"
            @bike_spec.instrument  = result[1]
            end
            if result[0]== "Seat"
            @bike_spec.seat  = result[1]
            end
            if result[0]== "Carrying capacity"
            @bike_spec.carrying_capacity  = result[1]
            end
            if result[0]== "Oil capacity"
            @bike_spec.oil_capacity  = result[1]
            end
            if result[0]== "Reserve fuel capacity"
            @bike_spec.reserve  = result[1]
            end  
            if result[0]== "Light"
            @bike_spec.headlamp  = result[1]
            end  
            if result[0]== "Top speed"
            @bike_spec.top_speed  = result[1]
            end
          end                                                  
        end
      end
    end
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

    if !params[:bike_spec][:link].empty?
      
      doc = Nokogiri::HTML(open(params[:bike_spec][:link]))
      start = false
      doc.css('table tr td table tr td table tr').each do |link|
        fiel= link.content.to_s
        if fiel.include? "Displacement"
          start=true
        end
        if start

          if fiel.include? "Sell or buy used bikes"
            break
          end
          if fiel.include? ":"
            result= fiel.split(":")

            if result[0]== "Displacement"
            @bike_spec.displacement= result[1]
            end
            if result[0]== "Engine type"
            @bike_spec.engine= result[1]
            end
            if result[0]== "Power"
            @bike_spec.max_power= result[1]
            end            
            if result[0]== "Torque"
            @bike_spec.max_torque= result[1]
            end            
            if result[0]== "Compression"
              compression= result[1]+":"+ result[2]
            @bike_spec.bore= compression
            end
            if result[0]== "Bore x stroke"
            @bike_spec.stroke= result[1]
            end
            if result[0]== "Valves per cylinders"
            @bike_spec.valve_per_cylinder= result[1]
            end
            if result[0]== "Fuel system"
            @bike_spec.no_of_cylinders= result[1]
            end
            if result[0]== "Fuel control"
            @bike_spec.fuel_control= result[1]
            end
            if result[0]== "Ignition"
            @bike_spec.ignition= result[1]
            end
            if result[0]== "Lubrication system"
            @bike_spec.lubrication= result[1]
            end
            if result[0]== "Cooling system"
            @bike_spec.cooling_type= result[1]
            end
            if result[0]== "Gearbox"
            @bike_spec.transmission= result[1]
            end
            if result[0]== "Transmission type,final drive"
            @bike_spec.transmission_type= result[1]
            end
            if result[0]== "Clutch"
            @bike_spec.clutch= result[1]
            end
            if result[0]== "Exhaust system"
            @bike_spec.exhaust= result[1]
            end
            if result[0]== "Frame type"
            @bike_spec.chassis_type= result[1]
            end
            if result[0]== "Rake (fork angle)"
            @bike_spec.rake= result[1]
            end
            if result[0]== "Trail"
            @bike_spec.trail= result[1]
            end
            if result[0]== "Front suspension"
            @bike_spec.suspension_front= result[1]
            end
            if result[0]== "Front suspension travel"
            @bike_spec.fs_travel= result[1]
            end
            if result[0]== "Rear suspension"
            @bike_spec.suspension_rear= result[1]
            end
            if result[0]== "Rear suspension travel"
            @bike_spec.rs_travel= result[1]
            end
            if result[0]== "Front tyre dimensions"
            @bike_spec.wheel_type= result[1]
            end
            if result[0]== "Rear tyre dimensions"
            @bike_spec.wheel_size= result[1]
            end
            if result[0]== "Front brakes"
            @bike_spec.brakes_front= result[1]
            end
            if result[0]== "Front brakes diameter"
            @bike_spec.fb_diameter= result[1]
            end
            if result[0]== "Rear brakes"
            @bike_spec.brakes_rear= result[1]
            end
            if result[0]== "Rear brakes diameter"
            @bike_spec.rb_diameter= result[1]
            end
            if result[0]== "Dry weight"
            @bike_spec.weight= result[1]
            end
            if result[0]== "Weight incl. oil, gas, etc"
            @bike_spec.g_weight= result[1]
            end
            if result[0]== "Power/weight ratio"
            @bike_spec.pw_ratio= result[1]
            end
            if result[0]== "Seat height"
            @bike_spec.seat_height= result[1]
            end
            if result[0]== "Overall height"
            @bike_spec.height= result[1]
            end
            if result[0]== "Overall length"
            @bike_spec.length= result[1]
            end
            if result[0]== "Overall width"
            @bike_spec.width= result[1]
            end
            if result[0]== "Ground clearance"
            @bike_spec.ground_clearance= result[1]
            end
            if result[0]== "Wheelbase"
            @bike_spec.wheelbase= result[1]
            end
            if result[0]== "Fuel capacity"
            @bike_spec.fuel_tank= result[1]
            end
            if result[0]== "Wheels"
            @bike_spec.wheel= result[1]
            end
            if result[0]== "Engine details"
            @bike_spec.engine_detail = result[1]
            end
            if result[0]== "Greenhouse gases"
            @bike_spec.greenhouse  = result[1]
            end
            if result[0]== "Driveline"
            @bike_spec.driveline  = result[1]
            end
            if result[0]== "Fuel consumption"
            @bike_spec.fuel_consumption  = result[1]
            end
            if result[0]== "Emission details"
            @bike_spec.emmission  = result[1]
            end
            if result[0]== "Electrical"
            @bike_spec.electrical  = result[1]
            end
            if result[0]== "Starter"
            @bike_spec.starter  = result[1]
            end
            if result[0]== "Instruments"
            @bike_spec.instrument  = result[1]
            end
            if result[0]== "Seat"
            @bike_spec.seat  = result[1]
            end
            if result[0]== "Carrying capacity"
            @bike_spec.carrying_capacity  = result[1]
            end
            if result[0]== "Oil capacity"
            @bike_spec.oil_capacity  = result[1]
            end
            if result[0]== "Reserve fuel capacity"
            @bike_spec.reserve  = result[1]
            end 
            if result[0]== "Light"
            @bike_spec.headlamp  = result[1]
            end 
            if result[0]== "Top speed"
            @bike_spec.top_speed  = result[1]
            end           
          end                                                  
        end
      end
    end

    @bike_spec.updated = Time.now
    respond_to do |format|
      if !params[:bike_spec][:link].empty?
        @bike_spec.save
        format.html { redirect_to @bike_spec, notice: 'Bike spec was successfully updated.' }
      else
        if @bike_spec.update_attributes(params[:bike_spec])
          format.html { redirect_to @bike_spec, notice: 'Bike spec was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @bike_spec.errors, status: :unprocessable_entity }
        end
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
  @bikes = BikeSpec.latest.with_price.desc(:year)
  @latest_bike = @bikes.desc(:year, :updated).limit(3)
  @models= @bikes.distinct(:model)
  @makes= @bikes.distinct(:make)
  set_meta_tags :title => 'Search New Bikes for sale in Nepal, get their specs, price',
              :description => "Search  new for sale, Find new bike for sale &amp; 
    new bike dealer specials at bikes.bechnu.com - Nepal's newest bike website.",
              :keywords => 'Bike, sale, new bike, specs',
              :canonical => "http://bikes.bechnu.com/showroom/"
  
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
