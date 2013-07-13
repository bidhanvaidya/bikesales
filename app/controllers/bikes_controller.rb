#Indentation Complete
class BikesController < ApplicationController
  # GET /bikes
  # GET /bikes.json
  before_filter :authenticate_user!, :only => [:new, :edit,:create, :owner,:save_search]
  before_filter :owner, :only => [:destroy]
  before_filter :marketing_ad, :only => [:edit, :update,:delete_picture]

  def index

    @bikes = Bike.all
    @type_selection = params[:type]
    @make_selection = params[:make]
    @model_selection = params[:model]
    @color_selection = params[:color]
    @body_selection =  params[:body]
    @location_selection = params[:location]

    if params[:price_from].to_i < params[:price_to].to_i
      print "hello"
      @price_from_selection = params[:price_from]
      @price_to_selection = params[:price_to]
    else

      @price_from_selection = params[:price_to]
      @price_to_selection = params[:price_from]
    end    

    @bikes=@bikes.where(type: @type_selection ) if !@type_selection.nil?
    @bikes=@bikes.make(@make_selection) if !@make_selection.nil?
    @bikes=@bikes.where(model: @model_selection) if !@model_selection.nil?
    @bikes=@bikes.where(color: @color_selection) if !@color_selection.nil?
    @bikes=@bikes.where(:price.gt => @price_from_selection) if !@price_from_selection.nil?
    @bikes=@bikes.where(:price.lt => @price_to_selection) if !@price_to_selection.nil?
    @bikes=@bikes.where(location: @location_selection) if !@location_selection.nil?
    @bikes=@bikes.where(body: @body_selection) if !@body_selection.nil?
  
  
    @types= @bikes.distinct(:type).sort
    @models= @bikes.distinct(:model).sort
    @bodies= @bikes.distinct(:body).sort
    
    @makes= @bikes.distinct(:make).sort
    @colors= @bikes.distinct(:color).sort
    @location= @bikes.distinct(:location).sort
    if params[:sort] == "price" and params[:direction] == "asc" 
      @bikes = @bikes.asc(:price)
    elsif params[:sort] == "price" and params[:direction] == "desc"
      @bikes= @bikes.desc(:price)
      
    elsif params[:sort] == "year" and params[:direction] == "asc" 
      @bikes = @bikes.asc(:year)
    elsif params[:sort] == "year" and params[:direction] == "desc"
      @bikes= @bikes.desc(:year)
       elsif params[:sort] == "latest"
      @bikes= @bikes.desc(:created)
    else
        @bikes= @bikes.desc(:created)
      
      
    end
    @bikees=@bikes.paginate(:page => params[:page], :per_page => 10)
    set_meta_tags :title => 'Search for New and Used bikes, get prices and compare',
              :description => "Bike for sale, to a the nepali public, "+
              [@models, @makes, @location].reject(&:nil?).reject(&:empty?).join(', '),
              :keywords => "Bike, sale, nepal, "+[@models, @makes].reject(&:nil?).reject(&:empty?).join(', '),
              :canonical => bikes_url(make:params[:make], model: params[:model])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bikes }
    end
  end

  # GET /bikes/1
  # GET /bikes/1.json
  def show
    @bike = Bike.find(params[:id])
    @bike_spec = @bike.bike_spec
    @clicked=@bike.clicked+1
    @bike.update_attributes(clicked: @clicked)
    @bikes= Bike.all
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
    @bikes=@bikes.where(location: @location_selection) if !@location_selection.nil?
    @bikes=@bikes.where(body: @body_selection) if !@body_selection.nil?
  
    
    @types= @bikes.distinct(:type)
    @models= @bikes.distinct(:model)
    @bodies= @bikes.distinct(:body)
    
    @makes= @bikes.distinct(:make)
    @colors= @bikes.distinct(:color)
    @location= @bikes.distinct(:location)
    if params[:sort] == "price" and params[:direction] == "asc" 
      @bikes = @bikes.asc(:price)
    elsif params[:sort] == "price" and params[:direction] == "desc"
      @bikes= @bikes.desc(:price)
      
    elsif params[:sort] == "year" and params[:direction] == "asc" 
      @bikes = @bikes.asc(:year)
    elsif params[:sort] == "year" and params[:direction] == "desc"
      @bikes= @bikes.desc(:year)
       elsif params[:sort] == "latest"
      @bikes= @bikes.desc(:created)
    else
        @bikes= @bikes.desc(:created)
    
    
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

    set_meta_tags :title => [@bike.year.to_s,@bike.make,@bike.model,@bike.variant].reject(&:nil?).reject(&:empty?).join(' '),
              :description => "Bike for sale, to a the nepali public, "+
              [@bike.year.to_s,@bike.make,@bike.model,@bike.variant, @bike.location,@bike.type, @bike.body, @bike.price.to_s, @bike.comment].reject(&:nil?).reject(&:empty?).join(', '),
              :keywords => "Bike for sale nepal"+[@bike.year.to_s,@bike.make,@bike.model,@bike.variant, @bike.location,@bike.type, @bike.body].reject(&:nil?).reject(&:empty?).join(', '),
              :canonical => bike_url(@bike)
    end
      respond_to do |format|
        format.html # show.html.erb
        format.js
        format.json { render json: @bike }
      end
  end

  # GET /bikes/new
  # GET /bikes/new.json
  def new
    @bike = Bike.new
    set_meta_tags :title => 'Post your Bike for sale!!',
              :description => "Post your bike for sale to a the nepali public, Sell my bike. Kathmandu, Bhaktapur, Lalitpur, Bharatpur, Pokhara",
              :keywords => 'Bike, sale, second hand, new bike, ad, seel my bike',
              :canonical => "bikes.bechnu.com/bikes/new/"
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bike }
    end
  end

  # GET /bikes/1/edit
  def edit
    @bike = Bike.unscoped.unvalidated.find(params[:id])
  end

  # POST /bikes
  # POST /bikes.json
  def create
    
    @bike = Bike.new(params[:bike])
    
    if current_user.email == "marketing@bikes.bechnu.com"
      @bike.validated = false 
    end
    @bike.updated = Time.now

    respond_to do |format|

      if @bike.save
        @bike = Bike.find(@bike)
        if BikeSpec.where(year: params[:bike][:year], make: params[:bike][:make], model: params[:bike][:model],variant: params[:bike][:variant]).empty?
       bike_spec= BikeSpec.where(make: params[:bike][:make], model: params[:bike][:model],variant: params[:bike][:variant]).first
    else
     bike_spec= BikeSpec.where(year: params[:bike][:year], make: params[:bike][:make], model: params[:bike][:model],variant: params[:bike][:variant]).first
    end
        
        @bike.bike_spec_id = bike_spec.id
        @bike.body = bike_spec.body
        @bike.user_id = current_user.id
        @bike.save
        UserMailer.send_to_spec(@bike).deliver  
          if current_user.provider == 'facebook'

            @user = FbGraph::User.me(current_user.facebook_token).fetch
            if @user.permissions.include?(:publish_actions)
              if @bike.pictures.empty?
                picture= 'https://s3.amazonaws.com/bikesbechnu_public/logo.png'
              else
                picture = @bike.pictures.first.file.url
              end
              link= 'http://bikes.bechnu.com/bikes/'+@bike.id+ '.html'
              @user.feed!(
              :message => @bike.comment,
              :picture => picture,
              :link => link,
              :name => 'BikeSales',
              :description =>  @bike.description )
            end

          end
        format.html { redirect_to @bike, notice: 'Bike was successfully created.' }
        format.json { render json: @bike, status: :created, location: @bike }
      else
        format.html { render action: "new", errors: @bike.errors.full_messages}
        format.json { render json: @bike.errors, status: :unprocessable_entity }
      end
    end
  end
  # PUT /bikes/1
  # PUT /bikes/1.json
  def update
      set_meta_tags :title => 'Update your Bike AD!!',
                    :description => 'Update for existing bike'
      @bike = Bike.unscoped.unvalidated.find(params[:id])
      if !BikeSpec.where(year: params[:bike][:year], make: params[:bike][:make], model: params[:bike][:model],variant: params[:bike][:variant]).empty?
      bike_spec= BikeSpec.where(year: params[:bike][:year], make: params[:bike][:make], model: params[:bike][:model],variant: params[:bike][:variant]).first
    else
     bike_spec= BikeSpec.where(make: params[:bike][:make], model: params[:bike][:model],variant: params[:bike][:variant]).first
     
    end
      @bike.bike_spec_id = bike_spec.id
      @bike.body = bike_spec.body
      @bike.updated = Time.now

      if current_user.email != "marketing@bikes.bechnu.com" 
        @bike.validated = true
      end
      @bike.user = current_user

      respond_to do |format|
        if @bike.update_attributes(params[:bike])
           UserMailer.send_to_spec(@bike).deliver  
          if current_user.provider == 'facebook'

            @user = FbGraph::User.me(current_user.facebook_token).fetch
            if @user.permissions.include?(:publish_actions)
              if @bike.pictures.empty?
                picture= 'https://s3.amazonaws.com/bikesbechnu_public/logo.png'
              else
                picture = @bike.pictures.first.file.url
              end
              link= 'http://bikes.bechnu.com/bikes/'+@bike.id+ '.html'
              @user.feed!(
              :message => @bike.comment,
              :picture => picture,
              :link => link,
              :name => 'BikeSales',
              :description =>  @bike.description )
            end

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
    @bike.expired= true


    respond_to do |format|
      if @bike.save
        format.html { redirect_to bikes_url }
        format.json { head :no_content }
      end
    end
  end
  def change_make
    @bikes=BikeSpec.distinct(:make).sort!
    respond_to do |format|
      format.js
    end
  end

  def change_model
    @bikes=BikeSpec.where(make: params[:make]).distinct(:model).sort
    respond_to do |format|
      format.js
    end
  end
  
  def change_variant
    @bikes=BikeSpec.where(model: params[:model]).distinct(:variant).sort
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

    set_meta_tags :title => 'Search New and Used Bikes for sale in Nepal',
              :description => "Search new and used bikes for sale in Nepal or sell, bechnu, bechnus your used bike for free. 
              Find new bike for sale and new bike, dealer specials at bikes.bechnu.com - Nepal's newest motorbike, motorcycle website.",
              :keywords => 'Nepal, Nepali, bike, bikes, motorcycle, motorcycles, motorbike, motorbikes, sale, sales, second hand, new bike, 
              new bikes, used bikes, specs',
              :canonical => "http://bikes.bechnu.com/"



    @bikes = Bike.all
    @models= @bikes.distinct(:model)
    @makes= @bikes.distinct(:make)
     
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
    make=params[:make] if !params[:make].empty?
    model=params[:model] if !params[:model].empty?
    price_from=params[:price_from] if !params[:price_from].empty?
    price_to=params[:price_to] if !params[:price_to].empty?
    location=params[:location] if params[:location] != "Any Cities"
    type=params[:type] if params[:type]!= 'Any Type'

    redirect_to bikes_path(make: make, model: model, type: type, 
      price_from: price_from, price_to: price_to, location: location)

  end
  def save_search
    bike= Bike.find(params[:id])
    current_user.favourites.create(bike_id: bike.id)
    respond_to do |format|
      format.js
     
    end
  end
  def send_to_friend
    sender = params[:sender]
    name= params[:name]
    to = params[:to]
    comment = params[:comment]
    bike=Bike.find(params[:bike])
    UserMailer.send_to_friend(sender,name, to, bike, comment).deliver  
    respond_to do |format|
      format.js
     
    end
  end
  def enquiry
    name = params[:name]
    email= params[:email]
    tel= params[:tel]
    comment= params[:comment]
    bike= Bike.find(params[:bike_id])
    UserMailer.enquiry(name, email, tel, comment, bike).deliver  
    respond_to do |format|
      format.js
     
    end
    
  end

  def delete_picture
    bike= Bike.find(params[:id])
    picture= bike.pictures.find(params[:picture_id])
    picture.file= nil
    picture.save
    picture.delete
    respond_to do |format|
      format.js

    end
     
  end
  
  private
  def owner
    @bike = Bike.find(params[:id])
    if current_user==@bike.user || current_user == User.first
      return true
    else
      redirect_to @bike
    end
  end
  def marketing_ad
    @bike = Bike.unscoped.unvalidated.find(params[:id])
     if current_user==@bike.user || current_user == User.first || @bike.validated==false
      return true
    else
      redirect_to @bike
    end
  end
  
end
