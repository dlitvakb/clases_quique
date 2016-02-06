class Persona
  def initialize(animales)
    @animales = animales
  end
  def largar_animales
    @animales.each do |animal|
      puts animal.hace_tu_gracia
    end
  end
end

class Animal
  def initialize(nombre, gracia)
    @nombre = nombre
    @gracia = gracia
  end

  def hace_tu_gracia
    "soy #{@nombre}, #{@gracia}"
  end
end

class Perro < Animal
  def initialize(nombre)
    super(nombre, 'doy la pata')
  end
end

class Gato < Animal
  def initialize(nombre)
    super(nombre, 'me lamo')
  end

  def hace_tu_gracia
    "#{super}, putoooo"
  end
end

class Elefante < Animal
  def initialize(nombre, edad)
    super(nombre, 'levanto la trompa')
    @edad = edad
  end

  def hace_tu_gracia
    mensaje = @edad > 50 ? 'soy re viejo' : 'soy re joven'

    "#{mensaje}, #{super}"
  end
end

class ElefanteDislexico < Elefante
  def hace_tu_gracia
    super.reverse
  end
end


Persona.new(
  [
    Perro.new('juan'),
    Gato.new('lelele'),
    Elefante.new('juancho', 35),
    ElefanteDislexico.new('asdasd', 89)
  ]
).largar_animales
