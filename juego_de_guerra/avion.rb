require './aereo'
require './cosa_que_carga'

class Avion < Aereo
  include CosaQueCarga

  def initialize
    super(10, 5, 1000)
  end
end
