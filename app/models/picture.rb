class Picture
  include Mongoid::Document
  include Mongoid::Paperclip
  attr_accessible :file, :bike_id
 field :bike_id, type: Integer
      
      embedded_in :bike, :inverse_of => :pictures
      has_mongoid_attached_file :file, :styles => { :medium => "330x229>", :thumb => "100x100>" }
end
