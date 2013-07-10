class BikeSpec
  include Mongoid::Document
  attr_accessible :make, :model, :body, :variant, :year, :price, :updated, :created,

:top_speed, :fuel_consumption_city, :fuel_consumption_highway, :displacement, :engine, :max_power, :max_torque,  
:transmission, :clutch, :bore, :stroke, :no_of_cylinders, :valve_per_cylinder, :chassis_type, :cooling_type,
:length, :width, :height, :weight, :ground_clearance, :fuel_tank, :wheelbase, :headlamp, :battery_type, :battery_voltage,
:battery_capacity, :wheel_type, :wheel_size, :tyre_type, :suspension_front, :suspension_rear, 
:brakes_front, :brakes_rear, :stand_alarm, :fuel_gauge, :ignition, :tacho_meter, :trip_meter, :speedometer,
:pictures_attributes, :fuel_control, :lubrication, :transmission_type, :exhaust, :rake, :trail, :fs_travel, 
:rs_travel, :fb_diameter, :rb_diameter, :g_weight, :pw_ratio, :seat_height,:link, :wheel, :engine_detail,
:greenhouse, :driveline, :fuel_consumption, :emmission, :electrical, :starter, :instrument, :seat, 
:carrying_capacity, :oil_capacity, :reserve
  embeds_many :pictures, :cascade_callbacks => true
  accepts_nested_attributes_for :pictures, :allow_destroy => true
  scope :latest, where(:year.gt => (Time.now.year-1))
  scope :sort, desc(:year)
  has_many :bikes
  belongs_to :user



  field :make, type: String
  field :model, type: String
  field :body, type: String
  field :variant, type: String
  field :year, type: Integer
  field :price, type: Integer
  field :updated, type: Time, default: ->{ Time.now }
  field :created, type: Time, default: ->{ Time.now }
  field :top_speed
  field :fuel_consumption_city, type: Float
  field :fuel_consumption_highway, type: Float


  ##ENGINE SPECIFICATIONS
  field :displacement
  field :engine
  field :max_power
  field :max_torque
  field :transmission
  field :clutch
  field :bore, type: String #Compression
  field :stroke, type: String #bore x Stroke
  field :no_of_cylinders, type: String # Fuel System
  field :valve_per_cylinder, type: Integer
  field :chassis_type
  field :cooling_type

  #    Displacement: 149.4cc
  #    Engine: 149.4cc, 4-stroke
  #    Maximum Power:  17.58 Bhp @ 10500 rpm
  #    Maximum Torque: 12.66 Nm @ 8500 rpm
  #    Gears:  6 Manual
  #    Clutch: Wet Multi Plate
  #    Bore: 63.5
  #    Stroke: 47.2
  #    No. of Cylinders: 1
  #    Valve Per Cylinder: 4
  #    Chassis Type: Twin Tube Diamond
  #   Cooling Type: Liquid Cooling

  ## DIMENSIONS
  field :length
  field :width
  field :height

  #    Length: 2000.00 mm
  #    Width:  825.00 mm
  #   Height: 1120.00 mm


  ##OTHER SPECIFICATIONS
  field :weight
  field :ground_clearance
  field :fuel_tank
  field :wheelbase
  field :headlamp
  field :battery_type
  field :battery_voltage, type: Float
  field :battery_capacity, type: Float
  field :wheel_type
  field :wheel_size
  field :tyre_type #tubeless


  #      Weight: 138.00 kg
  #     Ground Clearance: 190.00 mm
  #     Fuel Tank:  13.00 ltrs
  #     Wheelbase:  1305.00 mm
  #      Headlamp: 12V 60/55W H4
  #      Battery Type: Maintenance Free
  #      Battery Voltage:  12V
  #     Battery Capacity: 6Ah
  #     Wheel Type: Alloys
  #     Wheel Size: 100/80-17 - 130/70-17 mm
  #     Tubeless: 
  #     Colors: Black with Pearl Sunbeam White, Sports Red with Pearl Sunbeam White

  #ACTIVE AND PASSIVE SAFETY
  field :suspension_front
  field :suspension_rear
  field :brakes_front
  field :brakes_rear
  field :stand_alarm

  ##Suspension(Front):  Tube Type One Side Operation
  #Suspension(Rear): Tube Type Both Side Operation
  #Brakes: 276mm Disc
  #Brakes(Rear): 220mm Disc
  #Stand Alarm:  
  #
  #COMFORT AND CONVENIENCE

  field :fuel_gauge
  field :ignition ##self start or kick or both
  field :tacho_meter
  field :trip_meter
  field :speedometer

  #Fuel Guage: Digital
  #Self Start: 
  #Tacho Meter:  Analogue
  #Trip Meter: Digital-2
  #Speedometer:  Digital
##new ones
field :fuel_control
field :lubrication
field :transmission_type
field :exhaust
field :rake
field :trail
field :fs_travel
field :rs_travel
field :fb_diameter
field :rb_diameter
field :g_weight
field :pw_ratio
field :seat_height
field :wheel
field :engine_detail
field :greenhouse
field :driveline
field :fuel_consumption
field :emmission
field :electrical
field :starter
field :instrument
field :seat
field :carrying_capacity
field :oil_capacity
field :reserve

def link
     link=nil
   end

end