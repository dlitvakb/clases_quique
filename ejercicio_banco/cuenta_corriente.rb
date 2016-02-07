require './cuenta'

class CuentaCorriente < Cuenta
  def corriente?
    true
  end

  def depositar(monto)
    super(monto - (monto * 21.0/100))
  end

  def tipo_cuenta
    'corriente'
  end
end
