class Unidad
  attr_reader :vida

  def initialize(ataque, defensa, vida)
    @ataque = ataque
    @defensa = defensa
    @vida = vida
  end

  def atacar(otra_unidad)
    otra_unidad.defender(@ataque) if puede_atacar?(otra_unidad)
  end

  def defender(ataque)
    @vida -= ataque * (1.0/@defensa)
  end

  def puede_atacar?(otra_unidad)
    raise "not implemented"
  end

  def aereo?
    false
  end

  def terrestre?
    false
  end

  def naval?
    false
  end

  def muerto?
    @vida <= 0
  end
end
