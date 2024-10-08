require 'date'

class Vehicle
  attr_reader :vin, :year, :make, :model, :engine, :county
  attr_accessor :plate_type, :registration_date, :data
              
  def initialize(vehicle_details)
    @vin = vehicle_details[:vin]
    @year = vehicle_details[:year]
    @make = vehicle_details[:make]
    @model = vehicle_details[:model]
    @engine = vehicle_details[:engine]
    @county = vehicle_details[:county]
    @registration_date = nil
    @data = data
  end

  def antique?
    Date.today.year - @year >= 25
  end

  def electric_vehicle?
    @engine == :ev
  end
  
end


