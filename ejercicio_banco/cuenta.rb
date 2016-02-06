require './sin_saldo_error'

class Cuenta
  attr_reader :monto
  def initialize
    @monto = 0
  end

  def depositar(monto)
    @monto += monto
  end

  def retirar(monto)
    @monto -= monto
    monto
  end

  def ahorro?
    false
  end

  def corriente?
    false
  end
end
