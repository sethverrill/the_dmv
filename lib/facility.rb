class Facility
  attr_reader :name, :address, :phone, :services, :holidays_closed
  attr_accessor :registered_vehicles, :collected_fees

  def initialize(facility_hash)
    @name = facility_hash[:name]
    @address = facility_hash[:address]
    @phone = facility_hash[:phone]
    @holidays_closed = facility_hash[:holidays_closed]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    if @services.include?('Vehicle Registration')
      vehicle.registration_date = Date.today
      vehicle.plate_type = determine_plate_type(vehicle)
      @registered_vehicles << vehicle
      @collected_fees += calculate_fee(vehicle)
      vehicle
    else
      nil
    end
  end

  def determine_plate_type(vehicle)
    if vehicle.year <= 1999
      :antique
    elsif vehicle.engine == :ev
      :ev
    else
      :regular
    end
  end

  def calculate_fee(vehicle)
    if vehicle.plate_type == :antique
      25
    elsif vehicle.plate_type == :ev
      200
    else
      100
    end
  end

  def administer_written_test(registrant)
    if @services.include?('Written Test') &&
      registrant.permit? && registrant.age >= 16
      registrant.pass_written_test
      true
    else
      false
    end
  end

  def administer_road_test(registrant)
    if @services.include?('Road Test') &&
      registrant.passed_written_test?
      registrant.pass_road_test
      registrant.earn_license
      true
    else
      false
    end
  end

  def renew_license(registrant)
    if @services.include?('Renew License') &&
      registrant.has_license?
      renew = registrant.renew_license      
      renew
    else
      false
    end
  end
 
end
