require 'spec_helper'

RSpec.describe FacilityFactory do
  before(:each) do
    @factory = FacilityFactory.new
    @dds = DmvDataService.new
  end

  it 'exitst' do
    expect(@factory).to be_an_instance_of(FacilityFactory)
  end

  it 'can create Colorado facilities' do
    co_data = @dds.co_dmv_office_locations
    facilities = @factory.create_facilities(co_data, 'CO')

    # expect(facilities).to be_an_instance_of(Facility)
    expect(facilities.size).to eq(co_data.size)
    
    first_facility = facilities.first
    first_data = co_data.first

    expect(first_facility.name).to eq(first_data[:dmv_office])
    expect(first_facility.address).to include(first_data[:address_li], first_data[:city], first_data[:state], first_data[:zip])
    expect(first_facility.phone).to eq(first_data[:phone])
  
  end

end