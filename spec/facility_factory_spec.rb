require 'spec_helper'

RSpec.describe FacilityFactory do
  before(:each) do
    @factory = FacilityFactory.new
  end
  it 'exitst' do
    expect(@factory).to be_an_instance_of(FacilityFactory)
  end


end