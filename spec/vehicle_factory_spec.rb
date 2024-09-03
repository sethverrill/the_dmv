require './spec/spec_helper'

RSpec.describe VehicleFactory do
  before(:each) do
    @factory = VehicleFactory.new
    @dds = DmvDataService.new
  end

  it 'exists' do
    expect(@factory).to be_an_instance_of(VehicleFactory)
  end

  it 'works with fake vehicles' do
    cars = [
      {vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice},
      {vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev},
      {vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice}
    ]
    vehicles = @factory.create_vehicles(cars)
    first_vehicle = vehicles[0]
    second_vehicle = vehicles[1]
    third_vehicle = vehicles[2]
    expect(vehicles.size).to eq 3
    expect(first_vehicle.vin).to eq('123456789abcdefgh')
    expect(second_vehicle.year).to eq(2019)
    expect(first_vehicle.make).to eq('Chevrolet')
    expect(third_vehicle.model).to eq('Camaro')
    expect(second_vehicle.engine).to eq(:ev)
  end

  it 'can create a single instance of a vehicle' do
    car = {vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice}
  
    vehicle = @factory.create_vehicle(car)

    expect(vehicle).to be_an_instance_of(Vehicle)
    expect(vehicle.vin).to eq('1a2b3c4d5e6f')
    expect(vehicle.make).to eq('Chevrolet')
    expect(vehicle.engine).to eq(:ice)
  end

  it 'can create washington ev data' do
    wa_evs_data = @dds.wa_ev_registrations
    wa_evs = @factory.create_wa_vehicles(wa_evs_data)
    expect(wa_evs).to all(be_an_instance_of(Vehicle))

    wa_ev_24 = wa_evs[23]
    wa_ev_101 = wa_evs[100]
    wa_ev_412 = wa_evs[411]
    wa_ev_888 = wa_evs[887]

    expect(wa_ev_24.make).to eq("TESLA")
    expect(wa_ev_101.model).to eq("XC90")
    expect(wa_ev_412.vin).to eq("1C4RJXU66R")
    expect(wa_ev_888.year).to eq("2015")
    expect(wa_ev_412.county).to eq("King")

  end

  it 'handles no data' do
    no_data = []
    vehicles = @factory.create_vehicles(no_data)

    expect(vehicles).to be_empty
  end
end