module BikeSpecsHelper

	def crawl(year_from, year_end)


			f=File.new('error_log', 'w')
			total= 0
			errors=0
			for i in year_from..year_end
			all_link= "http://www.bikez.com/year/index.php?year="+i.to_s
						
			doc = Nokogiri::HTML(open(all_link))
			first = true
			doc.css('table tr td table tr td table tr th').each do |link|

				previous= nil
				if !first 
						table= link.parent().parent()
						table.css("tr").each do |brand|

							count= 0
							brand.css("td").each do |counter|
								count= count+1

							end

							if count==3 || count ==1

								bike= brand.first_element_child().content.split(" ")
								make= bike[0]
								if bike[1] =~ /\d/         # Calling String's =~ method.
									new_bike= bike[1].split(bike[1][/\d+/])
									if new_bike[0].nil?
										model= bike[1]
										
										if !bike[2].nil?
											variant = bike[2..-1].join(" ")
										end
									else
										model= new_bike[0]
										if new_bike[2..-1].nil?
											variant = bike[1][/\d+/]
										else
											variant = bike[1][/\d+/]+new_bike[1]
										end 
									end
								else
									model= bike[1]
									variant = bike[2..-1].join(" ")
								end
								bike_link= nil
								href = true
								brand.css("a").each do |url|
									if href	

										bike_link= url["href"].gsub('../', 'http://www.bikez.com/') 


									end
									href= false
								end
								#puts bike_link
								#f.write("#{bike_link}")
								#f.write ("\n")
								

								begin

									doc_page = Nokogiri::HTML(open(bike_link))
												
									start = false
									bike_spec= BikeSpec.where(year: i.to_i, make: make, model: model, variant: variant).find_or_initialize_by

									
									
									doc_page.css('table tr td table tr td table tr').each do |link|
										fiel= link.content.to_s
										if fiel.include? "Model"
											start=true
										end
										if start

											if fiel.include? "Sell or buy used bikes"
												break
											end
											if fiel.include? ":"
												result= fiel.split(":")
												if result[0]== "Category"
										          bike_spec.body= result[1]
										        end
												if result[0]== "Displacement"
									            bike_spec.displacement= result[1]
									            end
									            if result[0]== "Engine type"
									            bike_spec.engine= result[1]
									            end
									            if result[0]== "Power"
									            bike_spec.max_power= result[1]
									            end            
									            if result[0]== "Torque"
									            bike_spec.max_torque= result[1]
									            end            
									            if result[0]== "Compression"
									              compression= result[1]+":"+ result[2]
									            bike_spec.bore= compression
									            end
									            if result[0]== "Bore x stroke"
									            bike_spec.stroke= result[1]
									            end
									            if result[0]== "Valves per cylinders"
									            bike_spec.valve_per_cylinder= result[1]
									            end
									            if result[0]== "Fuel system"
									            bike_spec.no_of_cylinders= result[1]
									            end
									            if result[0]== "Fuel control"
									            bike_spec.fuel_control= result[1]
									            end
									            if result[0]== "Ignition"
									            bike_spec.ignition= result[1]
									            end
									            if result[0]== "Lubrication system"
									            bike_spec.lubrication= result[1]
									            end
									            if result[0]== "Cooling system"
									            bike_spec.cooling_type= result[1]
									            end
									            if result[0]== "Gearbox"
									            bike_spec.transmission= result[1]
									            end
									            if result[0]== "Transmission type,final drive"
									            bike_spec.transmission_type= result[1]
									            end
									            if result[0]== "Clutch"
									            bike_spec.clutch= result[1]
									            end
									            if result[0]== "Exhaust system"
									            bike_spec.exhaust= result[1]
									            end
									            if result[0]== "Frame type"
									            bike_spec.chassis_type= result[1]
									            end
									            if result[0]== "Rake (fork angle)"
									            bike_spec.rake= result[1]
									            end
									            if result[0]== "Trail"
									            bike_spec.trail= result[1]
									            end
									            if result[0]== "Front suspension"
									            bike_spec.suspension_front= result[1]
									            end
									            if result[0]== "Front suspension travel"
									            bike_spec.fs_travel= result[1]
									            end
									            if result[0]== "Rear suspension"
									            bike_spec.suspension_rear= result[1]
									            end
									            if result[0]== "Rear suspension travel"
									            bike_spec.rs_travel= result[1]
									            end
									            if result[0]== "Front tyre dimensions"
									            bike_spec.wheel_type= result[1]
									            end
									            if result[0]== "Rear tyre dimensions"
									            bike_spec.wheel_size= result[1]
									            end
									            if result[0]== "Front brakes"
									            bike_spec.brakes_front= result[1]
									            end
									            if result[0]== "Front brakes diameter"
									            bike_spec.fb_diameter= result[1]
									            end
									            if result[0]== "Rear brakes"
									            bike_spec.brakes_rear= result[1]
									            end
									            if result[0]== "Rear brakes diameter"
									            bike_spec.rb_diameter= result[1]
									            end
									            if result[0]== "Dry weight"
									            bike_spec.weight= result[1]
									            end
									            if result[0]== "Weight incl. oil, gas, etc"
									            bike_spec.g_weight= result[1]
									            end
									            if result[0]== "Power/weight ratio"
									            bike_spec.pw_ratio= result[1]
									            end
									            if result[0]== "Seat height"
									            bike_spec.seat_height= result[1]
									            end
									            if result[0]== "Overall height"
									            bike_spec.height= result[1]
									            end
									            if result[0]== "Overall length"
									            bike_spec.length= result[1]
									            end
									            if result[0]== "Overall width"
									            bike_spec.width= result[1]
									            end
									            if result[0]== "Ground clearance"
									            bike_spec.ground_clearance= result[1]
									            end
									            if result[0]== "Wheelbase"
									            bike_spec.wheelbase= result[1]
									            end
									            if result[0]== "Fuel capacity"
									            bike_spec.fuel_tank= result[1]
									            end
									            if result[0]== "Wheels"
									            bike_spec.wheel= result[1]
									            end
									            if result[0]== "Engine details"
									            bike_spec.engine_detail = result[1]
									            end
									            if result[0]== "Greenhouse gases"
									            bike_spec.greenhouse  = result[1]
									            end
									            if result[0]== "Driveline"
									            bike_spec.driveline  = result[1]
									            end
									            if result[0]== "Fuel consumption"
									            bike_spec.fuel_consumption  = result[1]
									            end
									            if result[0]== "Emission details"
									            bike_spec.emmission  = result[1]
									            end
									            if result[0]== "Electrical"
									            bike_spec.electrical  = result[1]
									            end
									            if result[0]== "Starter"
									            bike_spec.starter  = result[1]
									            end
									            if result[0]== "Instruments"
									            bike_spec.instrument  = result[1]
									            end
									            if result[0]== "Seat"
									            bike_spec.seat  = result[1]
									            end
									            if result[0]== "Carrying capacity"
									            bike_spec.carrying_capacity  = result[1]
									            end
									            if result[0]== "Oil capacity"
									            bike_spec.oil_capacity  = result[1]
									            end
									            if result[0]== "Reserve fuel capacity"
									            bike_spec.reserve  = result[1]
									            end
									            if result[0]== "Light"
									            bike_spec.headlamp  = result[1]
									            end 
									            if result[0]== "Top speed"
									            bike_spec.top_speed  = result[1]
									            end         

												#puts result[0]
												#puts result[1]
												#f.write(fiel)
												#f.write ("\n")
											end
										end
									end
									bike_spec.save
								rescue
									puts "error in"
									puts bike_link
									f.write(" error in #{i} at #{bike_link} for #{previous} ")
									f.write(" error count #{errors}\n")
									errors=errors+1
									#f.write(" error count #{errors}\n")
								else

									#f.write(" success in #{i} #{bike_link}, ")
									f.write(" Input counter:  #{total}\n")
									previous= bike_link
									total=total+1
									print total
									puts i
									puts [make,model,variant].join(" ")

								end


							elsif count ==2
								if brand.first_element_child()['width'] == '300'
									bike= brand.first_element_child().next_sibling().content.split(" ")
									make= bike[0]
									if bike[1] =~ /\d/         # Calling String's =~ method.
										new_bike= bike[1].split(bike[1][/\d+/])
										if new_bike[0].nil?
											model= bike[1]
											variant = bike[2..-1].join(" ")
										else
											model= new_bike[0]
											if new_bike[2..-1].nil?
												variant = bike[1][/\d+/]
											else
												variant = bike[1][/\d+/]+new_bike[1]
											end 
										end
									else
										model= bike[1]
										variant = bike[2..-1].join(" ")
									end
									bike_link= nil
									href = true
									brand.css("a").each do |url|
										if href	

											bike_link= url["href"].gsub('../', 'http://www.bikez.com/') 


										end
										href= false
									end
									#puts bike_link
									#f.write(bike_link)
									#f.write ("\n")
									#puts [make,model,variant].join(" ")
									begin
										doc_page = Nokogiri::HTML(open(bike_link))
										bike_spec= BikeSpec.where(year: i.to_i, make: make, model: model, variant:variant).find_or_initialize_by
										start = false
										doc_page.css('table tr td table tr td table tr').each do |link|
											fiel= link.content.to_s
											if fiel.include? "Model"
												start=true
											end
											if start

												if fiel.include? "Sell or buy used bikes"
													break
												end
												if fiel.include? ":"
													result= fiel.split(":")
													if result[0]== "Category"
										            bike_spec.body= result[1]
										            end
													if result[0]== "Displacement"
										            bike_spec.displacement= result[1]
										            end
										            if result[0]== "Engine type"
										            bike_spec.engine= result[1]
										            end
										            if result[0]== "Power"
										            bike_spec.max_power= result[1]
										            end            
										            if result[0]== "Torque"
										            bike_spec.max_torque= result[1]
										            end            
										            if result[0]== "Compression"
										              compression= result[1]+":"+ result[2]
										            bike_spec.bore= compression
										            end
										            if result[0]== "Bore x stroke"
										            bike_spec.stroke= result[1]
										            end
										            if result[0]== "Valves per cylinders"
										            bike_spec.valve_per_cylinder= result[1]
										            end
										            if result[0]== "Fuel system"
										            bike_spec.no_of_cylinders= result[1]
										            end
										            if result[0]== "Fuel control"
										            bike_spec.fuel_control= result[1]
										            end
										            if result[0]== "Ignition"
										            bike_spec.ignition= result[1]
										            end
										            if result[0]== "Lubrication system"
										            bike_spec.lubrication= result[1]
										            end
										            if result[0]== "Cooling system"
										            bike_spec.cooling_type= result[1]
										            end
										            if result[0]== "Gearbox"
										            bike_spec.transmission= result[1]
										            end
										            if result[0]== "Transmission type,final drive"
										            bike_spec.transmission_type= result[1]
										            end
										            if result[0]== "Clutch"
										            bike_spec.clutch= result[1]
										            end
										            if result[0]== "Exhaust system"
										            bike_spec.exhaust= result[1]
										            end
										            if result[0]== "Frame type"
										            bike_spec.chassis_type= result[1]
										            end
										            if result[0]== "Rake (fork angle)"
										            bike_spec.rake= result[1]
										            end
										            if result[0]== "Trail"
										            bike_spec.trail= result[1]
										            end
										            if result[0]== "Front suspension"
										            bike_spec.suspension_front= result[1]
										            end
										            if result[0]== "Front suspension travel"
										            bike_spec.fs_travel= result[1]
										            end
										            if result[0]== "Rear suspension"
										            bike_spec.suspension_rear= result[1]
										            end
										            if result[0]== "Rear suspension travel"
										            bike_spec.rs_travel= result[1]
										            end
										            if result[0]== "Front tyre dimensions"
										            bike_spec.wheel_type= result[1]
										            end
										            if result[0]== "Rear tyre dimensions"
										            bike_spec.wheel_size= result[1]
										            end
										            if result[0]== "Front brakes"
										            bike_spec.brakes_front= result[1]
										            end
										            if result[0]== "Front brakes diameter"
										            bike_spec.fb_diameter= result[1]
										            end
										            if result[0]== "Rear brakes"
										            bike_spec.brakes_rear= result[1]
										            end
										            if result[0]== "Rear brakes diameter"
										            bike_spec.rb_diameter= result[1]
										            end
										            if result[0]== "Dry weight"
										            bike_spec.weight= result[1]
										            end
										            if result[0]== "Weight incl. oil, gas, etc"
										            bike_spec.g_weight= result[1]
										            end
										            if result[0]== "Power/weight ratio"
										            bike_spec.pw_ratio= result[1]
										            end
										            if result[0]== "Seat height"
										            bike_spec.seat_height= result[1]
										            end
										            if result[0]== "Overall height"
										            bike_spec.height= result[1]
										            end
										            if result[0]== "Overall length"
										            bike_spec.length= result[1]
										            end
										            if result[0]== "Overall width"
										            bike_spec.width= result[1]
										            end
										            if result[0]== "Ground clearance"
										            bike_spec.ground_clearance= result[1]
										            end
										            if result[0]== "Wheelbase"
										            bike_spec.wheelbase= result[1]
										            end
										            if result[0]== "Fuel capacity"
										            bike_spec.fuel_tank= result[1]
										            end
										            if result[0]== "Wheels"
										            bike_spec.wheel= result[1]
										            end
										            if result[0]== "Engine details"
										            bike_spec.engine_detail = result[1]
										            end
										            if result[0]== "Greenhouse gases"
										            bike_spec.greenhouse  = result[1]
										            end
										            if result[0]== "Driveline"
										            bike_spec.driveline  = result[1]
										            end
										            if result[0]== "Fuel consumption"
										            bike_spec.fuel_consumption  = result[1]
										            end
										            if result[0]== "Emission details"
										            bike_spec.emmission  = result[1]
										            end
										            if result[0]== "Electrical"
										            bike_spec.electrical  = result[1]
										            end
										            if result[0]== "Starter"
										            bike_spec.starter  = result[1]
										            end
										            if result[0]== "Instruments"
										            bike_spec.instrument  = result[1]
										            end
										            if result[0]== "Seat"
										            bike_spec.seat  = result[1]
										            end
										            if result[0]== "Carrying capacity"
										            bike_spec.carrying_capacity  = result[1]
										            end
										            if result[0]== "Oil capacity"
										            bike_spec.oil_capacity  = result[1]
										            end
										            if result[0]== "Reserve fuel capacity"
										            bike_spec.reserve  = result[1]
										            end
										            if result[0]== "Light"
										            bike_spec.headlamp  = result[1]
										            end 
										            if result[0]== "Top speed"
										            bike_spec.top_speed  = result[1]
										            end    										            
													#puts result[0]
													#puts result[1]
													#f.write(fiel)
													#f.write ("\n")
												end
											end
										end
										bike_spec.save
									rescue
										puts "error in"
										puts bike_link
										f.write(" error in #{i} #{bike_link} after #{previous} ")
										errors=errors+1
										f.write(" error count #{errors}\n")
									else
										#f.write(" success in #{i} #{bike_link}, ")
										f.write(" input counter: #{total}\n")

										previous= bike_link
										total=total+1
										puts total
										puts i
										puts [make,model,variant].join(" ")
										
									end
								end
							end
						end

				else
						first= false
				end
				
				

				#f.write(" toal error count #{errors}")
				#f.write(" total success #{total}")
			end	
			end
				f.close()

	end
	def hero
		BikeSpec.where(make: "Hero", :year.lt=> 2012).each do |a|
			honda=["Honda"]
			make= [a.make, honda].join(" ")
			model=a.model
			variant= a.variant
			new_model= variant.split(" ")
			final_model= new_model[0]
			#puts a.variant
			count=new_model.count-1
			final_variant= new_model[1..count].join(" ")
			if final_model=="Super"
				final_model= "Splendor"
				final_variant = ["Super", final_variant[8..-1].split(" ")].join(" ")
			end

			puts [make,final_model,final_variant].join(" ")
			a.make= make
			a.model= final_model
			a.variant= final_variant
			a.save
		end
		BikeSpec.where(make: "Hero Honda",variant:"Super Splendor").update_all(variant:"Super 125", model: "Splendor")
	end
	def count
		@models= BikeSpec.all.distinct(:model)
		@models.each do |model|
		puts BikeSpec.where(model: model).count
        end 

	end
	def change_body
		bikes= BikeSpec.where(:displacement.exists => true)
		allround= bikes.where(body: "Allround")
		allround.each do |all|
			displacement= all.displacement.split(" ")
			displacement= displacement[0].to_i
			if displacement<=150
				puts [all.make, all.model, all.variant, "Standard"].join(" ")
				all.body= "Standard"
			elsif displacement>150 and displacement<=400
				puts [all.make, all.model, all.variant, "Sports"].join(" ")
				all.body= "Sports"
			else
				puts [all.make, all.model, all.variant, "Super Sport"].join(" ")
				all.body= "Super Sport"
			end
			all.save

		end
		naked= bikes.where(body: "Naked bike")
		naked.each do |all|
			displacement= all.displacement.split(" ")
			displacement= displacement[0].to_i
			if displacement<=150
				puts [all.make, all.model, all.variant, "Standard"].join(" ")
				all.body= "Standard"
			elsif displacement>150 and displacement<=400
				puts ["Naked bike",all.make, all.model, all.variant, "Sports"].join(" ")
				all.body= "Sports"
			else
				puts ["Naked bike",all.make, all.model, all.variant, "Super Sport"].join(" ")
				all.body= "Super Sport"
			end
			all.save

		end
		sport= bikes.where(body: "Sport")
		sport.each do |all|
			displacement= all.displacement.split(" ")
			displacement= displacement[0].to_i
			if displacement<=400
				puts ["Sport",all.make, all.body, all.variant, "Sports"].join(" ")
				all.body= "Sports"
			else
				puts ["Sport",all.make, all.body, all.variant, "Super Sport"].join(" ")
				all.body= "Super Sport"
			end
			all.save

		end
		sport_touring= bikes.where(body: "Sport touring")
		sport_touring.each do |all|
			displacement= all.displacement.split(" ")
			displacement= displacement[0].to_i
			if displacement<=400
				puts ["Sport touring",all.make, all.model, all.variant, "Sports"].join(" ")
				all.body= "Sports"
			else
				puts ["Sport touring",all.make, all.model, all.variant, "Super Sport"].join(" ")
				all.body= "Super Sport"
			end
			all.save

		end


		BikeSpec.where(body: "Cross / motocross").update_all(body: "Trail")
		BikeSpec.where(body: "Enduro / offroad").update_all(body: "Trail")
		BikeSpec.where(body: "Super motard").update_all(body: "Trail")
		BikeSpec.where(body: "ATV").update_all(body: "Trail")
		BikeSpec.where(body: "Trial").update_all(body: "Trail")
		BikeSpec.where(body: "Classic").update_all(body: "Standard")
		BikeSpec.where(body: "Custom / cruiser").update_all(body: "Cruiser")
		BikeSpec.where(body: "Touring").update_all(body: "Cruiser")
		BikeSpec.where(:displacement.exists => false, body: "Sport").update_all(body: "Sports")
		BikeSpec.where(:displacement.exists => false, body: "Allround").update_all(body: "Standard")
		BikeSpec.where(:displacement.exists => false, body: "Sport touring").update_all(body: "Super Sport")

	end
	def copy(year, make, model, variant, from, to)
		bike= BikeSpec.where(year: year, make: make, model: model, variant: variant).first
		for y in from..to
			if BikeSpec.where(year: y, make: make, model: model, variant: variant).empty?
				
				puts "new entry"
				new_bike = BikeSpec.new(bike.attributes)

				new_bike.year= y
				new_bike.save
				puts new_bike
				puts [y, make, model, variant].join(" ")
			else
			puts "exists"
			puts [y, make, model, variant].join(" ")
			end
		end

	
	end
		def copy_no_v(year, make, model, from, to)
		bike= BikeSpec.where(year: year, make: make, model: model).first
		for y in from..to
			if BikeSpec.where(year: y, make: make, model: model).empty?
				
				puts "new entry"
				new_bike = BikeSpec.new(bike.attributes)

				new_bike.year= y
				new_bike.save
				puts new_bike
				puts [y, make, model].join(" ")
			else
			puts "exists"
			puts [y, make, model].join(" ")
			end
		end

	
	end
	def empty_model
		bikes=BikeSpec.where(model: "")
		bikes.each do |bike|
			bike.model= bike.variant
			bike.variant= "N/A"
			bike.save
		end
		
	end


end