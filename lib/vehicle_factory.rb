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

  def create_wa_vehicles(arr)
    arr.map do |data|
      create_wa_vehicle(data)
    end
  end

  def create_wa_vehicle(data)
    Vehicle.new({
      vin: data[:vin_1_10],
      year: data[:model_year],    
      make: data[:make],
      model: data[:model],
      county: data[:county]
    })
  end  
end