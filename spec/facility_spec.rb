require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
    @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
    @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
    @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@facility).to be_an_instance_of(Facility)
      expect(@facility.name).to eq('DMV Tremont Branch')
      expect(@facility.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility.phone).to eq('(720) 865-4600')
      expect(@facility.services).to eq([])
      expect(@facility.registered_vehicles).to eq([])
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility.services).to eq([])
      @facility.add_service('New Drivers License')
      @facility.add_service('Renew Drivers License')
      @facility.add_service('Vehicle Registration')
      expect(@facility.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end

  describe '#has registered vehicles and charges' do   
    it 'has registerd vehicles' do
      @facility.add_service('Vehicle Registration')
      expect(@facility.registered_vehicles).to eq([])
      @facility.register_vehicle(@cruz)
      expect(@facility.registered_vehicles.map(&:model)).to eq(["Cruz"])
      @facility.register_vehicle(@camaro)
      expect(@facility.registered_vehicles.map(&:make)).to eq(["Chevrolet", "Chevrolet"])
      @facility.register_vehicle(@bolt)
      expect(@facility.registered_vehicles.map(&:engine)).to eq([:ice, :ice, :ev])
      expect(@facility.registered_vehicles.count).to eq(3)
    end   

    it 'charges to provide service' do
      expect(@facility.collected_fees).to eq(0)
      @facility.add_service('Vehicle Registration')
      @facility.register_vehicle(@cruz)
      expect(@facility.collected_fees).to eq (100)
      @facility.register_vehicle(@camaro)
      expect(@facility.collected_fees).to eq (125)
      @facility.register_vehicle(@bolt)
      expect(@facility.collected_fees).to eq (325)
    end

    it 'will not perform a service it does not provide' do
      expect(@facility.register_vehicle(@cruz)).to eq(nil)
    end

    it 'can determine plate type' do
      expect(@facility.determine_plate_type(@camaro)).to eq(:antique)
      expect(@facility.determine_plate_type(@cruz)).to eq(:regular)
      expect(@facility.determine_plate_type(@bolt)).to eq(:ev)        
    end

    it 'will not affect other facilities' do
  end

  describe '#can provide license services' do
    it 'gives written test when registrant is eligible'do
      registrant.give_permit

      expect(@facility.administer_written_test(registrant)).to be true
      expect(@facility.passed_written_test?).to be true
    end

    it 'will not give a test if registrant not eligible' do

      expect(@facility.administer_written_test(registrant)).to be false
      expect(@facility.passed_written_test?).to be false
    end

    it 'performs the road test when written test is passed' do
      registrant.passed_written_test

      expect(@facility.administer_road_test(registrant)).to be true
      expect(@registrant.has_license?).to be true
    end

    it 'does not perform without passed written test' do
      expect(@facility.administer_road_test(registrant)).to be false
      expect(@registrant.has_license?).to be false
    end

    it 'renews license if registrant has license' do
      registrant.earn_license

      expect(@facility.renew_license(registrant)).to be true
    end

    it 'does not renew license if registrant has no license' do
      expect(facility.renew_license(registrant)).to be false
    end
  end
end
      

  
end
