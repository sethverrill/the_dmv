require './spec/spec_helper'

puts "STATISTICS!!!"


def popular_ev
  @dds = DmvDataService.new
  wa_evs_data = @dds.wa_ev_registrations

  mm_count = Hash.new(0)
  wa_evs_data.each do |vehicle|
     make_model = "#{vehicle[:make]}, #{vehicle[:model]}"
      mm_count[make_model] += 1
  end
  

  highest_make_model = mm_count.max_by { |_, count| count }
  "The most popular electric vehicle in Washington is the #{highest_make_model[0]} with #{highest_make_model[1]} registrations!"
end

def model_year
  @dds = DmvDataService.new
  wa_evs_data = @dds.wa_ev_registrations

  year_count = Hash.new(0)
  wa_evs_data.each do |vehicle|
    year_count[vehicle[:model_year]] += 1
    
  end    
    specific_year = year_count["2021"]
    "The number of 2021 model EVs registered is #{specific_year}"
  
end

def county_cars
  @dds = DmvDataService.new
  wa_evs_data = @dds.wa_ev_registrations

  county_count = Hash.new(0)
  wa_evs_data.each do |county|
    county_count[county[:county]] += 1
    
  end    
    highest_county = county_count.max_by {|_, count| count}
    "The county with the highest number of EVs is #{highest_county[0]} with #{highest_county[1]} registrations!"
end


  

p popular_ev
p model_year
p county_cars

