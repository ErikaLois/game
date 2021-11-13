import wollok.game.*
import elementos.*

class Consumibles inherits Elementos{
	var property aporta 
	override method puedePisarse() = false
	override method puedeConsumirse() = true
	override method puedeRecibirDanio() = false
	override method movete(dir) {}
	
	//Abstract
	method serConsumido(player)
	
	
}
class Energia inherits Consumibles{
	override method serConsumido(player){
		game.removeVisual(self)
		player.energia(player.energia() + aporta)
		
	}
}

class Salud inherits Consumibles{
	override method serConsumido(player){
		game.removeVisual(self)
		player.salud(player.salud() + aporta)
		
	}
}

class Municion inherits Consumibles{
	override method puedePisarse() = true
	override method serConsumido(player){
		game.removeVisual(self)
		player.municiones(player.municiones() + aporta)
	}
}

class Dinero inherits Consumibles{
	var property quita = 3
	override method puedePisarse() = true
	override method serConsumido(player){
		game.removeVisual(self)
		player.dinero(player.dinero() + aporta)	
		player.salud(player.salud() - quita)	
	}
}