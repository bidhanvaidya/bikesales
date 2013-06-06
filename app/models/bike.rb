class Bike
  include Mongoid::Document
  include Mongoid::Search

      attr_accessible :year, :make, :model, :variant, :price, :odometer, :body, :type, :color, :engine_capacity, :rego_no, :reg_expiry, :vin_no, :address, :phone, :comment,:pictures_attributes

      embeds_many :pictures, :cascade_callbacks => true
      accepts_nested_attributes_for :pictures, :allow_destroy => true

  
  field :year, type: Integer
  field :make, type: String
  field :model, type: String
  field :variant, type: String
  field :price, type: Integer
  field :odometer, type: Float
  field :body, type: String
  field :type, type: String
  field :color, type: String
  field :engine_capacity, type: Integer
  field :rego_no, type: String
  field :reg_expiry, type: Date
  field :vin_no, type: String
  field :address, type: String
  field :phone, type: String
  field :comment, type: String
  belongs_to :bike_spec
  belongs_to :user
  search_in :make, :model


   def self.make(make)
    where(make: make)
  end
     def self.model(model)
    where(model: model)
  end
     def self.type_selection(type)
    where(type: type)
  end
  def self.type(color)
    where(color: color)
  end
end
