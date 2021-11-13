import elementos.*
import wollok.game.*
import enemigo.*
import consumibles.*
import utilidades.*


class CeldaSorpresa{
	var property position
	var property image
	var property puntos
	method puedePisarse() = true
	method puedeConsumirse() = false
	method puedeRecibirDanio() = false
	
	
}	
class CeldasAtributos inherits CeldaSorpresa{
	 method afectar(player) 
 	
}
class CeldaEnergiaResta inherits CeldasAtributos {
 	
 	override method afectar(player) { 
 		player.energia(player.energia() - puntos)
 		game.removeVisual(self)	
 	}
 	
}
class CeldaEnergiaSuma inherits CeldasAtributos {
 	
 	override method afectar(player) { 
 		player.energia(player.energia() + puntos)
 		game.removeVisual(self)	
 	}
 	
}
class CeldaTeleport inherits CeldasAtributos{
	override method afectar(player){
		player.position(utilidades.posRandom())
		game.removeVisual(self)
	}
}
class CeldaElementoRandom inherits CeldasAtributos {
 	override method afectar(player){
 		game.addVisual(new Salud(image='botiquin.png',aporta=30,position= utilidades.posRandom()))
 		game.removeVisual(self)
 	} 	
}

