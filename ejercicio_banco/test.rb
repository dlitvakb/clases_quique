require 'minitest'
require 'minitest/autorun'
require './banco'
require './persona'
require './cuenta'
require './cuenta_ahorro'
require './cuenta_corriente'
require './sin_saldo_error'
require './cuenta_no_permitida_error'

class BancoTests < Minitest::Test
  def test_banco_tiene_nombre
    banco = Banco.new('banco luis')

    assert_equal 'banco luis', banco.nombre
  end

  def test_banco_agregar_personas
    banco = Banco.new('blah')

    assert_equal [], banco.personas

    banco.agregar_persona('pepe')

    assert_equal ['pepe'], banco.personas
  end

  def test_banco_buscar_persona_por_nombre
    pepe = Persona.new('pepe')
    banco = Banco.new('blah')

    banco.agregar_persona(pepe)

    assert_equal pepe, banco.buscar_persona_por_nombre('pepe')
  end

  def test_banco_transferir_entre_personas_entre_cajas_ahorro
    persona_1 = Persona.new('pepe')
    persona_2 = Persona.new('luis')

    banco = Banco.new('blah')

    banco.agregar_persona(persona_1)
    banco.agregar_persona(persona_2)

    persona_1.cuenta_ahorro.depositar(100)

    assert_equal 100, persona_1.cuenta_ahorro.monto
    assert_equal 0, persona_2.cuenta_ahorro.monto

    banco.transferir(
      banco.buscar_persona_por_nombre('pepe'),
      banco.buscar_persona_por_nombre('luis'),
      100,
      :ahorro
    )

    assert_equal 0, persona_1.cuenta_ahorro.monto
    assert_equal 100, persona_2.cuenta_ahorro.monto
  end

  def test_banco_transferir_entre_personas_entre_cajas_corrientes
    persona_1 = Persona.new('pepe')
    persona_1.agregar_cuenta(CuentaCorriente.new)

    persona_2 = Persona.new('luis')
    persona_2.agregar_cuenta(CuentaCorriente.new)

    banco = Banco.new('blah')

    banco.agregar_persona(persona_1)
    banco.agregar_persona(persona_2)

    persona_1.cuenta_corriente.depositar(100)

    assert_equal 79.0, persona_1.cuenta_corriente.monto
    assert_equal 0, persona_2.cuenta_corriente.monto

    banco.transferir(
      banco.buscar_persona_por_nombre('pepe'),
      banco.buscar_persona_por_nombre('luis'),
      79.0,
      :corriente
    )

    assert_equal 0, persona_1.cuenta_corriente.monto
    assert_equal (79.0 - 79.0 * 21.0 / 100), persona_2.cuenta_corriente.monto
  end
end

class PersonaTests < Minitest::Test
  def test_persona_tiene_una_cuenta_ahorro_por_defecto
    persona = Persona.new('pepe')

    assert_equal 1, persona.cuentas.size

    assert_equal true, persona.cuentas.first.ahorro?
  end

  def test_persona_cuenta_ahorro
    persona = Persona.new('pepe')

    assert_equal persona.cuentas.first, persona.cuenta_ahorro
  end

  def test_persona_cuenta_corriente
    persona = Persona.new('pepe')
    cuenta = CuentaCorriente.new

    persona.agregar_cuenta(cuenta)

    assert_equal cuenta, persona.cuenta_corriente
  end

  def test_persona_agregar_cuenta
    persona = Persona.new('pepe')
    cuenta = CuentaCorriente.new

    persona.agregar_cuenta(cuenta)

    assert_equal 2, persona.cuentas.size
    assert_equal cuenta, persona.cuentas[-1]
  end

  def test_persona_puede_tener_una_cuenta_de_cada_tipo
    persona = Persona.new('pepe')

    cuenta_corriente_1 = CuentaCorriente.new
    cuenta_corriente_2 = CuentaCorriente.new

    cuenta_ahorro_2 = CuentaAhorro.new

    begin
      persona.agregar_cuenta(cuenta_ahorro_2)
      fail "no deberia llegar aca"
    rescue CuentaNoPermitidaError => e
      assert_equal "ahorro", e.message
    end

    persona.agregar_cuenta(cuenta_corriente_1)

    begin
      persona.agregar_cuenta(cuenta_corriente_2)
      fail "no deberia llegar aca"
    rescue CuentaNoPermitidaError => e
      assert_equal "corriente", e.message
    end
  end

  def test_persona_cuenta_ahorro_no_puede_tener_saldo_negativo
    persona = Persona.new('pepe')

    begin
      persona.cuenta_ahorro.retirar(100)
      fail "no deberia llegar aca"
    rescue SinSaldoError => e
      assert_equal "no tenes saldo suficiente", e.message
    end
  end

  def test_persona_cuenta_corriente_no_puede_tener_saldo_negativo
    persona = Persona.new('pepe')
    cuenta = CuentaCorriente.new
    persona.agregar_cuenta(cuenta)

    persona.cuenta_corriente.retirar(100)

    assert_equal -100, persona.cuenta_corriente.monto
  end

  def test_persona_transfiere_entre_sus_cuentas_ahorro_a_corriente
    persona = Persona.new('pepe')
    cuenta = CuentaCorriente.new
    persona.agregar_cuenta(cuenta)

    persona.cuenta_ahorro.depositar(100)

    assert_equal 100, persona.cuenta_ahorro.monto
    assert_equal 0, persona.cuenta_corriente.monto

    persona.transferir(100, :ahorro, :corriente)

    assert_equal 0, persona.cuenta_ahorro.monto
    assert_equal 79.0, persona.cuenta_corriente.monto
  end

  def test_persona_transfiere_entre_sus_cuentas_corriente_a_ahorro
    persona = Persona.new('pepe')
    cuenta = CuentaCorriente.new
    persona.agregar_cuenta(cuenta)

    persona.cuenta_corriente.depositar(100)

    assert_equal 79.0, persona.cuenta_corriente.monto
    assert_equal 0, persona.cuenta_ahorro.monto

    persona.transferir(79.0, :corriente, :ahorro)

    assert_equal 0, persona.cuenta_corriente.monto
    assert_equal 79.0, persona.cuenta_ahorro.monto
  end
end

class CuentaAhorroTests < Minitest::Test
  def test_cuenta_ahorro_depositar
    cuenta = CuentaAhorro.new

    assert_equal 0, cuenta.monto

    cuenta.depositar(100)

    assert_equal 100, cuenta.monto
  end
end

class CuentaCorrienteTests < Minitest::Test
  def test_cuenta_corriente_depositar_tiene_iva
    cuenta = CuentaCorriente.new

    assert_equal 0, cuenta.monto

    cuenta.depositar(100)

    assert_equal 79.0, cuenta.monto
  end
end
