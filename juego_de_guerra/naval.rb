require './unidad'
require './cosa_que_carga'

class Naval < Unidad
  include CosaQueCarga

  def naval?
    true
  end

  def puede_atacar?(otra_unidad)
    false
  end
end
