class Caminante
  def initialize(cantidad: 0)
    @cantidad_patas = cantidad
  end

  def camina
    "yo camino en #{@cantidad_patas} patas"
  end
end

class Cuadrupedo < Caminante
  def initialize
    super(cantidad: 4)
  end
end

class Perro < Cuadrupedo
  def initialize(nombre)
    super
    @nombre = nombre
  end

  def ladra
    "guau, mi nombre es #{@nombre}"
  end
end

class Gato < Cuadrupedo
end

class Humano < Caminante
  def initialize
    super(cantidad: 2)
  end
end
