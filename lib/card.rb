require_relative 'journey.rb'
require_relative 'station.rb'

class Oystercard

  attr_reader :balance, :journey

    MAXIMUM_BALANCE = 90
    MINIMUM_CHARGE = 1

    def initialize
      @balance = 0
    end

    def top_up(amount)
      raise "Cannot top up: balance capacity of #{MAXIMUM_BALANCE} has been exceeded" if over_limit?(amount)
      @balance += amount
    end

     def touch_in(station)
       raise "Cannot touch in: not enough funds" if balance < MINIMUM_CHARGE
       @journey = Journey.new(station)
     end

     def touch_out(exit_station)
       @journey = Journey.new() if @journey.nil?
       @journey.end(exit_station)
       deduct(@journey.fare)
      #  @journey = nil
     end

     private

     def deduct(amount)
       @balance -= amount
     end

     def over_limit?(amount)
       balance + amount > MAXIMUM_BALANCE
     end

  end
