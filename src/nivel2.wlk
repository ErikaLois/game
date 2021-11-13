import wollok.game.*
import fondo.*
import personaje.*
import elementos.*
import marcador.*
import direcciones.*
import deposito.*
import consumibles.*
import inicio.*
import celdaSorpresa.*
import utilidades.*
import enemigo.*

object nivelLlaves {

	method configurate() {
		// fondo - es importante que sea el primer visual que se agregue
		game.addVisual(new Fondo(image="fondo.png"))
				 
		// otros visuals, p.ej. bloques o llaves
		//DINERO 
		const dinero1 = []
		10.times{dinero1.add(new Dinero(image = 'dinero.png', position = utilidades.posRandom(), aporta = 15))}
		dinero1.forEach{d => game.addVisual(d)}
		
		//MUNICIONES
		const municiones = []
		10.times{municiones.add(new Municion(image = 'granada.png', position = utilidades.posRandom(), aporta = 5))}
		
		//ENEMIGOS
		const enemigoNormal = new EnemigoNormal(position = game.at(3,1), image="alien.png",nivelDanio = 3,direccion = izquierda)
		const enemigoRandom = new EnemigoRandom(position = utilidades.posRandom(), image="alien.png",nivelDanio = 3,direccion = izquierda)
		const enemigoAcecho = new EnemigoAlAcecho(position = game.at(9,10), image="alien.png",nivelDanio = 3,direccion = izquierda)
		const enemigos = [enemigoNormal, enemigoRandom, enemigoAcecho]
		enemigos.forEach{e => game.addVisual(e)}
		
		//Movimiento de enemigos
		enemigos.forEach{ e => game.onTick(1000,"movimientoEnemigo",{
			if (e.seDesplazaNormal()){
				e.desplazarse()
			}else{
				e.desplazarseHacia(bubba)
			}
			
		})}
		
		//PUERTA 
			
		// personaje, es importante que sea el último visual que se agregue
		game.addVisual(bubba)
		
		// teclado
		// este es para probar, no es necesario dejarlo
		keyboard.up().onPressDo({ bubba.direccion(arriba) bubba.avanzar() })
		keyboard.down().onPressDo({ bubba.direccion(abajo) bubba.avanzar() })
		keyboard.left().onPressDo({ bubba.direccion(izquierda) bubba.avanzar() })
		keyboard.right().onPressDo({ bubba.direccion(derecha) bubba.avanzar() })
		keyboard.space().onPressDo({ bubba.comer()})		
		keyboard.any().onPressDo{self.comprobarSiGano(dinero)}
		

		// COLISIONES
	
		dinero1.forEach{ d => game.whenCollideDo(d, {player => d.serConsumido(bubba)})}
		
		municiones.forEach{ m => game.whenCollideDo(m, {player => m.serConsumido(bubba)})}
		
		enemigos.forEach{ e => game.whenCollideDo(e,{player => if(player.puedeRecibirDanio()){ e.hacerDanio(bubba)}})}
		
		
	}
	
	method comprobarSiGano(elemento) {
		if(!game.hasVisual(elemento)) {
			self.ganar()
		}
	}
	
	
	method ganar() {
		
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(image="fondo.png"))
		// después de un ratito ...
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="ganamos.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// fin del juego
				game.stop()
			})
		})
	}
	
	method perder(){
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(position = game.at(0,0),image="gameover.png"))
		// después de un ratito ...
		game.schedule(2500, {
			// cambio de fondo
			game.addVisual(new Fondo(image="niveles1.png"))
			
			// después de un ratito ...
			
			niveles.configurate()})
	}
	
	
}
