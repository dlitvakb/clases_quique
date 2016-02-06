class Banco
  attr_reader :nombre, :personas
  def initialize(nombre)
    @nombre = nombre
    @personas = []
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
end
