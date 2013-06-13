class BikeSpec
  include Mongoid::Document
  attr_accessible :make, :model, :body, :variant, :year, :price, :pictures_attributes
  field :make, type: String
  field :model, type: String
  field :body, type: String
  field :variant, type: String
  field :year, type: Integer
  field :price, type: Integer
  embeds_many :pictures, :cascade_callbacks => true
      accepts_nested_attributes_for :pictures, :allow_destroy => true
  
  has_many :bikes
end
