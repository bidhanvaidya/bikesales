class BikeSpec
  include Mongoid::Document
  field :make, type: String
  field :model, type: String
  field :body, type: String
  field :variant, type: String
  has_many :bikes
end
