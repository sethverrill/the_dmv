class VehicleFactory

  def initialize
  end


  def create_vehicles(source)
    vehicles = []
    source.each do |data|
    vehicles << create_vehicle(data)
    end
    vehicles
  end

  def create_vehicle(data)
    Vehicle.new(data)
  end
end