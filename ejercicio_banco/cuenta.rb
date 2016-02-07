require './sin_saldo_error'

class Cuenta
  attr_reader :monto
  def initialize
    @monto = 0
  end

  def self.from_json(json)
    nombre_clase = "Cuenta#{json[:tipo].capitalize}"
    cuenta = ::Object.const_get(nombre_clase).new
    cuenta.instance_variable_set(:@monto, json[:monto])

    cuenta
  end

  def depositar(monto)
    @monto += monto
  end

  def retirar(monto)
    @monto -= monto
    monto
  end

  def to_json
    {
      tipo: tipo_cuenta,
      monto: monto
    }
  end

  def tipo_cuenta
    raise 'implementar en subclase'
  end

  def ahorro?
    false
  end

  def corriente?
    false
  end
end
