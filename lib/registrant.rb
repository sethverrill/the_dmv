class Registrant
  attr_reader :name,
              :age,
              :permit,
              :license_data

  def initialize(name, age, permit = false)
    @name = name
    @age = age
    @permit = permit
    @license_data = {:written=>false, :license=>false, :renewed=>false}
    @pass_written_test = false
    @passed_road_test = false
    @has_license = false
  end

  def permit?
    @permit
  end

  def earn_permit
    @permit = true
  end

  def pass_written_test
    @license_data[:written] = true
  end

  def passed_written_test?
    @license_data[:written]
  end

  def pass_road_test
    @passed_road_test = true
  end

  def earn_license
    if @passed_road_test
      @license_data[:license] = true
      @has_license = true
    end
  end

  def has_license?
    @license_data[:license]
  end

  def renew_license
    if has_license?
      @license_data[:renewed] = true  
      true    
    else
      false
    end
  end
end
