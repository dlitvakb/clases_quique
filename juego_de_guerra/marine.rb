require './terrestre'

class Marine < Terrestre
  def initialize
    super(40, 80, 150)
  end

  def puede_atacar?(otra_unidad)
    true
  end
end
