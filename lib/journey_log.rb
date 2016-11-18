require_relative 'journey.rb'
require_relative 'station.rb'


class JourneyLog

  attr_reader :journeys, :journey_klass
  attr_accessor :current_journey

  def initialize(journey_klass)
    @journey_klass = journey_klass
    @journeys = []
  end

  def start(station)
    self.current_journey = journey_klass.new(station)
    self.journeys << current_journey
  end

  def finish(station)
      if current_journey
        current_journey.end(station)
      else
        self.current_journey = journey_klass.new
        self.journeys << current_journey
        current_journey.end(station)
      end

      self.current_journey = nil
  end



  # def last_journey
  #   @journeys.last
  # end
  #
  # private
  #
  #
  # # def current_journey
  # #   @current_journey || @journey_klass.new
  # # end

end
