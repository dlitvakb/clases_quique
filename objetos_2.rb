class Persona
  def initialize(cuenta)
    @cuenta = cuenta
  end

  def depositar(monto)
    @cuenta.depositar(monto)
  end

  def consultar_saldo
    @cuenta.saldo
  end
end

class Cuenta
  def initialize
    @monto = 0
  end

  def depositar(monto)
    @monto += monto
  end

  def saldo
    @monto
  end
end

pepe = Persona.new(Cuenta.new)

puts pepe.consultar_saldo

pepe.depositar(100)

puts pepe.consultar_saldo
