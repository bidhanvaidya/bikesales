class Picture
  include Mongoid::Document
  include Mongoid::Paperclip
  attr_accessible :file, :bike_id
 field :bike_id
      embedded_in :bike_spec, :inverse_of => :pictures
      embedded_in :bike, :inverse_of => :pictures
      has_mongoid_attached_file :file, 
       :path           => ':attachment/:id/:style.:extension',
    :storage        => :s3,
    
    :s3_credentials => File.join(Rails.root, 'config', 's3.yml'),
    :styles => {
      :thumb    => ['100x100',   :jpg],
      :original   => ['500x500',    :jpg]
    },
    :convert_options => { 
          :original => "-quality 92 -interlace Plane",
          :thumb => "-quality 92 -interlace Plane",
        }
end
