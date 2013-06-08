class BikesController < ApplicationController
  # GET /bikes
  # GET /bikes.json
   before_filter :authenticate_user!, :only => [:new, :create,:edit, :update, :destroy]

  def index
    
    @bikes = Bike.all

    b= Bike.full_text_search(params[:search]).size
    print b
    @type_selection = params[:type]
    @make_selection = params[:make]
    @model_selection = params[:model]
    @color_selection = params[:color]
    @body_selection =  params[:body]
    @price_from_selection = params[:price_from]
    @price_to_selection = params[:price_to]
    @location_selection = params[:location]

    @bikes=@bikes.where(type: @type_selection ) if !@type_selection.nil?
    @bikes=@bikes.make(@make_selection) if !@make_selection.nil?
    @bikes=@bikes.where(model: @model_selection) if !@model_selection.nil?
    @bikes=@bikes.where(color: @color_selection) if !@color_selection.nil?
    @bikes=@bikes.where(:price.gt => @price_from_selection) if !@price_from_selection.nil?
    @bikes=@bikes.where(:price.lt => @price_to_selection) if !@price_to_selection.nil?
    @bikes=@bikes.where(address: @location_selection) if !@location_selection.nil?

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
  @types= @bikes.distinct(:type)
  @models= @bikes.distinct(:model)

  @makes= @bikes.distinct(:make)
  @colors= @bikes.distinct(:color)
  @location= @bikes.distinct(:address)

  @bikees=@bikes.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bikes }
    end
  end

  # GET /bikes/1
  # GET /bikes/1.json
  def show
    @bike = Bike.find(params[:id])
    @bikes= Bike.all
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
    found = false
    @previous_bike = @bikes.first
  @bikes.each do |search_bike|
    if found == false
      if search_bike.id == @bike.id
        
        found=true
      else
        @previous_bike = search_bike
      end
    else
        @next_bike= search_bike
        break
      
    end
  end
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
        if current_user.provider == 'facebook'
        @user = FbGraph::User.me(current_user.facebook_token).fetch

        link= 'http://localhost:3000/bikes/'+@bike.id+ '.html'
        @user.feed!(
        :message => 'I am selling my byke',
        :picture => 'http://liveimages.bikesales.com.au/bikesales/general/content/gc4943126384701195668.jpg',
        :link => link,
        :name => 'BikeSales',
        :description =>  @bike.comment  )
      end
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
        if current_user.provider == 'facebook'
          @user = FbGraph::User.me(current_user.facebook_token).fetch

          link= 'http://localhost:3000/bikes/'+@bike.id+ '.html'
          @user.feed!(
          :message => 'I am selling my byke',
          :picture => 'http://liveimages.bikesales.com.au/bikesales/general/content/gc4943126384701195668.jpg',
          :link => link,
          :name => 'BikeSales',
          :description =>  @bike.comment  )
        end
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
  def change_picture
   bike= Bike.find(params[:id])
   @picture= bike.pictures.find(params[:pic_id])
  
  respond_to do |format|
    print view_context.image_path("test.png")
    format.js
  end

  end

  def search_page
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
  def main_page
    @bikes = Bike.all

 
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bikes }
    end

    
  end
  def facebook_post
    
  end

  def search
    make=nil
    model=nil
    price_from=nil
    price_to= nil
    location=nil
    type=nil
    make=params[:bikes_make] if !params[:bikes_make].empty?
    model=params[:bikes_model] if !params[:bikes_model].empty?
    price_from=params[:price_from] if !params[:price_from].empty?
    price_to=params[:price_to] if !params[:price_to].empty?
    location=params[:location] if !params[:location].empty?
    type=params[:type] if !params[:type].empty?

    redirect_to bikes_path(make: make, model: model, type: type, 
      price_from: price_from, price_to: price_to, location: location)

  end

end
