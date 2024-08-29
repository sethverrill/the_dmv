require './spec/spec_helper'

RSpec.describe Registrant do
  before(:each) do
    @registrant_1 = Registrant.new('Bruce', 18, true )
    @registrant_2 = Registrant.new('Penny', 15 )
  end

  describe '#initialize' do
    it 'can initialize' do
      @registrant = Registrant.new('Francis', 21)

      expect(@registrant).to be_an_instance_of(Registrant)
    end

    it 'has a name'do

      expect(@registrant_1.name).to eq("Bruce")
      expect(@registrant_2.name).to eq("Penny")
    end

    it 'has an age' do

      expect(@registrant_1.age).to eq(18)
      expect(@registrant_2.age).to eq(15)
    end

    it 'has a permit' do

      expect(@registrant_1.permit?).to eq true
      expect(@registrant_2.permit?).to eq false
    end

    it 'has license data' do

      expect(@registrant_1.license_data).to eq ({:written=>false, :license=>false, :renewed=>false})
      expect(@registrant_2.license_data).to eq ({:written=>false, :license=>false, :renewed=>false})
    end
  end

end
