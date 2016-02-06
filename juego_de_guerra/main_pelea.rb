require './avion'
require './helicoptero'
require './infanteria'
require './marine'
require './bote'
require './carguero'

avion = Avion.new
marine = Marine.new

until avion.muerto? || marine.muerto?
  puts "Comienza el turno"

  puts "Marine ataca avion:"
  marine.atacar(avion)
  puts "Vida avion: #{avion.vida}"

  puts "Avion ataca marine:"
  avion.atacar(marine)
  puts "Vida marine: #{marine.vida}"

  sleep(0.1)
end

if avion.muerto?
  puts "Gano marine"
else
  puts "Gano avion"
end
