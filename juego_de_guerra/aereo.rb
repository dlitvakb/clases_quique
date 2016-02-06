require './unidad'

class Aereo < Unidad
  def aereo?
    true
  end

  def puede_atacar?(otra_unidad)
    !otra_unidad.aereo?
  end
end
