require './terrestre'

class Infanteria < Terrestre
  def initialize
    super(40, 5, 200)
  end

  def puede_atacar?(otra_unidad)
    otra_unidad.terrestre?
  end
end
