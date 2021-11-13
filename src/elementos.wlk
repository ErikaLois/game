import wollok.game.*
import direcciones.*
class Elementos{
	var property position
	var property image 
	
	//Abstact
	method puedePisarse()
	method puedeConsumirse()
	method puedeRecibirDanio()
	method movete(direccion)
	
}
class Estrella inherits Elementos {
	const property llegadas =0
	
	override method puedePisarse() = false
	override method puedeConsumirse() = false
	override method puedeRecibirDanio() = false
	
	override method movete(direccion){
		self.validarLugar(direccion)
		position = direccion.moverSiguiente(self.position(),self)
	}
	
	method validarLugar(direccion){
		const posAlLado = direccion.moverSiguiente(self.position(),self)
		const hayLugar = game.getObjectsIn(posAlLado).all{ obj => obj.puedePisarse()

		}
		
		if(!hayLugar){
			throw new Exception(message = "No puedo moverme!")
		}
	}
	method afectar(player){
		player.retroceder()
		player.energia(player.energia()+1)
	}

	method estaBienPosicionada() {
		return llegadas.position() == self.position()
		//return llegadas.map{ l=> l.position()}.contains(self.position()) //TODO: Redefinir el (==) en Position!
	}	
}

