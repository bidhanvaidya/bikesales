class Picture
  include Mongoid::Document
  include Mongoid::Paperclip
  attr_accessible :file, :bike_id
 field :bike_id, type: Integer
      embedded_in :bike_spec, :inverse_of => :pictures
      embedded_in :bike, :inverse_of => :pictures
      has_mongoid_attached_file :file, :styles => { :medium => "500x500>", :thumb => "100x100>" }
end
