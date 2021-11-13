import wollok.game.*
import direcciones.*
import nivel1.*

object bubba {
	var property position = game.origin()
	var property image = "astrom.png"	
	var property energia = 30
	var property salud =  10
	var property dinero = 0
	var property municiones = 0
	var property direccion = izquierda
	method puedeRecibirDanio() = true
	
	// BUBBA COME	
	method comer(){
		const consumiblesArriba = self.objectoEnCeldaA(arriba).filter{ obj => obj.puedeConsumirse()}
		const consumiblesAbajo = self.objectoEnCeldaA(abajo).filter{ obj => obj.puedeConsumirse()}
		const consumiblesderecha = self.objectoEnCeldaA(derecha).filter{ obj => obj.puedeConsumirse()}
		const consumiblesizquierda = self.objectoEnCeldaA(izquierda).filter{ obj => obj.puedeConsumirse()}
		
		const todosLosConsumibles = [consumiblesArriba,consumiblesderecha,consumiblesAbajo,consumiblesizquierda].flatten()
		todosLosConsumibles.forEach{ consumible =>
			consumible.serConsumido(self)
			game.say(self,"Up!")
		}
	}
	
	// EMPUJAR ELEMENTOS -Estrellas
	
	// OBS
	method empujar(elemento){
		try{
			elemento.movete(self.direccion())
		}catch e{
			elemento.afectar(self)
			game.say(self,"Esta Atascada")
		}
	}
	method objectoEnCeldaA(dir){
		return game.getObjectsIn(dir.moverSiguiente(position,self))
	}


	method retroceder(){
		position = direccion.opuesto().moverSiguiente(position,self)
	}
		
	
	method morir(){
		//Falta implementar imagen al morir y implementar el metodo perder en nivel1
		image = "perdio.png"
		game.schedule(3000,{
			nivelBloques.perder()
				
			}
		)
		
	}
	//MOVIMIENTOS:
	method avanzar(){
		if(energia > 0){
			position = direccion.moverSiguiente(position,self)
			energia-=1
		}else{
			self.morir()
		}
		
	}
}
