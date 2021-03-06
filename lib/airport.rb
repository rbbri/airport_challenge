class Airport

  attr_reader :capacity, :location, :weather

  DEFAULT_CAPACITY = 20

  def initialize(location, capacity = DEFAULT_CAPACITY, weather = Weather.new)
    @location = location
    @capacity = capacity
    @weather = weather
    @planes = []
  end

  def take_off(plane)
    take_off_check(plane)
    remove(plane)
    plane.fly
  end

  def land(plane)
    landing_check(plane)
    plane.arrive(location)
    add(plane)
  end

  def add(plane)
    planes << plane
  end

  def remove(plane)
    planes.delete(plane)
  end

  def landing_check(plane)
    raise "Landing aborted for #{plane} at #{location}" if weather.stormy?
    raise "#{location} has no capacity" if full?
    raise "#{plane} currently at #{plane.location}" if plane.location != "Sky"
    "#{plane} cleared to land at #{location}"
  end

  def take_off_check(plane)
    raise "Take off aborted for #{plane} at #{location}" if weather.stormy?
    raise "#{plane} not at #{location}" if plane.location != location
    "#{plane} ready for take off from #{location}"
  end

  private
  attr_reader :planes

  def full?
    planes.count >= capacity
  end

end
