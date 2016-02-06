require './cuenta'

class CuentaAhorro < Cuenta
  def ahorro?
    true
  end

  def retirar(monto)
    fail SinSaldoError, "no tenes saldo suficiente" if self.monto - monto < 0
    super(monto)
  end
end
