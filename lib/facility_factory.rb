class FacilityFactory

  def initialize
  end

  def create_facilities(source, state)
    facilities = []
    source.each do |data|
      facilities << create_facility(data, state)
    end
    facilities
  end

  def create_facility(data, state)
    case state
    when 'CO'
      create_co_facility(data)
    when 'NY'
      create_ny_facility(data)
    when 'MO'
      create_mo_facility(data)
    else
      puts "No data for #{state}"
    end
  end

  def create_co_facility(data)
    address = [
      data[:address_li],
      data[:address__1],
      data[:city],
      data[:state],
      data[:zip]
    ].compact.join(', ')

    facility = Facility.new({
      name: data[:dmv_office],
      address: address,
      phone: data[:phone]
    })

    services = data[:services_p].split (', ')
    services.each do |service|
      facility.add_service(service)
    end
    facility
  end

  def create_ny_facility(data)
    address = [
      data[:street_address_line_1],
      data[:street_address_line_2],
      data[:city],
      data[:state],
      data[:zip_code]
    ].compact.join(', ')

    facility = Facility.new({
      name: data[:office_name],
      address: address,
      phone: data[:public_phone_number]
    })
  end
    


  
  
end