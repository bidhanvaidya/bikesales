class Bike
  include Mongoid::Document

      attr_accessible :year, :make, :model, :variant, :price, :odometer, :body, :type, :color, :engine_capacity, 
      :rego_no, :reg_expiry, :vin_no, :address, :contact_name, :location, :updated, :expired,:clicked,:phone,
      :description,:comment,:pictures_attributes, :validated
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
  field :location, type: String
  field :phone, type: String
  field :contact_name, type: String
  field :comment, type: String
  field :description, type: String
  field :expired, type: Boolean, default: false
  field :clicked, type: Integer, default: 0
  field :updated, type: Time, default: ->{ Time.now }
  field :created, type: Time, default: ->{ Time.now }
  field :validated, type: Boolean, default: true
  belongs_to :bike_spec
  belongs_to :user

default_scope where(expired: false, validated: true)
scope :unvalidated, where(expired: false)
validates_presence_of :year, :make, :model, :price, :variant, :type, :phone, :location
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
