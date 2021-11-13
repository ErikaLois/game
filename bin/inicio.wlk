import wollok.game.*
import fondo.*
import personaje.*
import marcador.*
import direcciones.*
import nivel1.*


object niveles {

	method configurate() {
		// fondo - es importante que sea el primer visual que se agregue
		game.addVisual(new Fondo(image= "niveles1.png"))

		game.addVisualIn( bubba,game.at(3,6))
		
		// Movimientos
		keyboard.s().onPressDo({self.irAJuego() })
		
		
		}
	method irAJuego() {
		
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="fondo.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// ... limpio todo de nuevo
				game.clear()
				// y arranco el siguiente nivel
				nivelBloques.configurate()	
			})
		})
	}
		
}
