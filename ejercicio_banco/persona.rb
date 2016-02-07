require './cuenta'
require './cuenta_ahorro'
require './cuenta_no_permitida_error'

class Persona
  attr_reader :nombre, :cuentas
  def initialize(nombre)
    @nombre = nombre
    @cuentas = [CuentaAhorro.new]
  end

  def self.from_json(json)
    persona = Persona.new(json[:nombre])
    persona.instance_variable_set(
      :@cuentas,
      json[:cuentas].map { |c| Cuenta.from_json(c) }
    )

    persona
  end

  def cuenta_ahorro
    cuentas.detect { |c| c.ahorro? }
  end

  def cuenta_corriente
    cuentas.detect { |c| c.corriente? }
  end

  def agregar_cuenta(cuenta)
    fail CuentaNoPermitidaError, "ahorro" if cuenta.ahorro?
    fail CuentaNoPermitidaError, "corriente" if cuenta.corriente? && !cuenta_corriente.nil?
    cuentas << cuenta 
  end

  def transferir(monto, origen, destino)
    extraido = send("cuenta_#{origen}").retirar(monto)
    send("cuenta_#{destino}").depositar(extraido)
  end

  def to_json
    {
      nombre: nombre,
      cuentas: cuentas.map { |c| c.to_json }
    }
  end
end
