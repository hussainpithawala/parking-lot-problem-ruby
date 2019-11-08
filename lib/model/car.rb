require_relative 'vehicle'

class Car < Vehicle
  def initialize(reg_number)
    super(reg_number)
  end
end