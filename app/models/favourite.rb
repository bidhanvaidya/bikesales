class Favourite
  include Mongoid::Document
  attr_accessible :bike_id
  field :bike_id, type: String
      


	embedded_in :user, :inverse_of => :favourites
      
end
