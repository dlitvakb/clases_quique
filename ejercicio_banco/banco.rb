require './persona'

class Banco
  attr_reader :nombre, :personas
  def initialize(nombre)
    @nombre = nombre
    @personas = []
  end

  def self.from_json(json)
    banco = Banco.new(json[:nombre])
    json[:personas].each do |persona|
      banco.agregar_persona(Persona.from_json(persona))
    end

    banco
  end

  def agregar_persona(persona)
    personas << persona
  end

  def buscar_persona_por_nombre(nombre)
    personas.detect { |p| p.nombre == nombre }
  end

  def transferir(persona_1, persona_2, monto, tipo_cuenta)
    extraido = persona_1.send("cuenta_#{tipo_cuenta}").retirar(monto)
    persona_2.send("cuenta_#{tipo_cuenta}").depositar(extraido)
  end

  def to_json
    {
      nombre: nombre,
      personas: personas.map { |p| p.to_json }
    }
  end
end
