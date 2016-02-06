require './avion'
require './helicoptero'
require './infanteria'
require './marine'
require './bote'
require './carguero'

bote = Bote.new
avion = Avion.new
carguero = Carguero.new

bote.cargar_persona('pepe')
avion.cargar_persona('juan')
carguero.cargar_persona('luis')

puts "Bote descarga a: #{bote.descargar_persona}"
puts "Avion descarga a: #{avion.descargar_persona}"
puts "Carguero descarga a: #{carguero.descargar_persona}"
