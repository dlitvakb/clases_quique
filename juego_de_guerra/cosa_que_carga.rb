module CosaQueCarga
  def initialize(*)
    super
    @personas = []
  end

  def cargar_persona(persona)
    @personas << persona
  end

  def descargar_persona
    @personas.shift
  end

  def descargar_todos
    until @personas.empty?
      descargar_persona
    end
  end
end
