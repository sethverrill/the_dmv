require './spec/spec_helper'

RSpec.describe FacilityFactory do
  before(:each) do
    @factory = FacilityFactory.new
    @dds = DmvDataService.new
  end

  it 'exist' do
    expect(@factory).to be_an_instance_of(FacilityFactory)
  end

  it 'can create Colorado facilities' do
    co_data = @dds.co_dmv_office_locations
    facilities = @factory.create_facilities(co_data, 'CO')

    expect(facilities).to all(be_an_instance_of(Facility))
    expect(facilities.size).to eq(co_data.size)
    
    first_facility = facilities.first
    first_data = co_data.first

    expect(first_facility.name).to eq("DMV Tremont Branch")
    expect(first_facility.address).to eq("2855 Tremont Place, Suite 118, Denver, CO, 80205")
    expect(first_facility.phone).to eq("(720) 865-4600")
    expect(first_facility.services).to eq(["vehicle titles", "registration", "renewals;  VIN inspections"])
  
  end

  it 'can create New York facilities' do
    ny_data = @dds.ny_dmv_office_locations
    facilities = @factory.create_facilities(ny_data, 'NY')

    expect(facilities).to all(be_an_instance_of(Facility))
    expect(facilities.size).to eq(ny_data.size)
    
    twenty_first_facility = facilities[20]
    twenty_first_data = ny_data[20]

    expect(twenty_first_facility.name).to eq("PORT JEFFERSON")
    expect(twenty_first_facility.address).to eq("1055 ROUTE 112, PORT JEFFERSON, NY, 11776")
    expect(twenty_first_facility.phone).to eq("7184774820")
  end

  it 'can create Missouri facilities' do
    mo_data = @dds.mo_dmv_office_locations
    facilities = @factory.create_facilities(mo_data, 'MO')

    expect(facilities).to all(be_an_instance_of(Facility))
    expect(facilities.size).to eq(mo_data.size)

    sixty_third_facility = facilities[62]
    sixty_third_data = mo_data[62]

    expect(sixty_third_facility.name).to eq ("DEXTER")
    expect(sixty_third_facility.address).to eq("119 VINE ST, DEXTER, MO, 63841")
    expect(sixty_third_facility.phone).to eq("(573) 624-8808")
  end

  it 'does not provide for other states' do
    mo_data = @dds.mo_dmv_office_locations
    expect(facilities = @factory.create_facility(mo_data, 'ME')).to eq ("No data for ME")
    expect(facilities = @factory.create_facility(mo_data, 'CA')).to eq("No data for CA")
  end    

end