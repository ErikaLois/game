import wollok.game.*
import fondo.*
import personaje.*
import elementos.*
import nivel2.*
import marcador.*
import direcciones.*
import deposito.*
import consumibles.*
import inicio.*
import celdaSorpresa.*
import utilidades.*
import enemigo.*

object nivelBloques {

	method configurate() {
		// fondo - es importante que sea el primer visual que se agregue
		game.addVisual(new Fondo(image= "fondo.png"))
		
		//DEPOSITO
		const randX = utilidades.randomX()
		const randY = utilidades.randomY()
		/*const deposito1 = [new Position(x=randX, y=randY), 
			new Position(x=randX, y=randY-1), new Position(x=randX, y=randY-2),
			new Position(x=randX+1, y=randY), new Position(x=randX+1, y=randY-1), new Position(x=randX+1, y=randY-2)]*/
		
		const deposito1  = [new Position(x=7, y=12), new Position(x=8, y=12),new Position(x=7, y=11), new Position(x=8, y=11),new Position(x=7, y=13),new Position(x=8, y=13)]
			.map{ p => self.dibujar(new Deposito(image="almacenaje2.png",position = p)) }
			
		const depositoCompleto = new Deposito(image = 'DEPOSITO.png', position = game.at(randX,randY))
			
		//deposito1.map{ p => self.dibujar(new Deposito(image = "almacenaje2.png", position = p))}
		
		
		
		//	estrellas
		const estrellas = [new Position(x=2, y=5), new Position(x=7, y=3), new Position(x=0, y=13), new Position(x=12, y=7)]
			.map{ p => self.dibujar(new Estrella(image = "estrella.png",position = p, llegadas = deposito1)) }
			
		// Llaves
		const llaves = [new Position(x=6, y=7), new Position(x=9, y=10)]
			.map{ p => self.dibujar(new Estrella(image = "llave1.png",position = p, llegadas = deposito1)) }
		
		
		//CONSUMIBLES
		
		// hamburguesas
		game.addVisual(new Energia(position=game.at(2,1),image = 'hamburger.png',aporta = 100))
		game.addVisual(new Energia(position=game.at(8,2),image = 'hamburger.png',aporta = 100))
		game.addVisual(new Energia(position=game.at(3,4),image = 'hamburger.png',aporta = 100))
		game.addVisual(new Energia(position=game.at(10,7),image = 'hamburger.png',aporta = 100))
		game.addVisual(new Energia(position=game.at(2,8),image = 'hamburger.png',aporta = 100))
		game.addVisual(new Energia(position=game.at(4,10),image = 'hamburger.png',aporta = 100))
		game.addVisual(new Energia(position=game.at(10,7),image = 'hamburger.png',aporta = 100))
		game.addVisual(new Energia(position=game.at(13,12),image = 'hamburger.png',aporta = 100))
		game.addVisual(new Energia(position=game.at(12,3),image = 'hamburger.png',aporta = 100))
		game.addVisual(new Energia(position=game.at(11,13),image = 'hamburger.png',aporta = 100))
		
		
		game.addVisual(new Salud(position=game.at(4,2),image = 'botiquin.png',aporta = 5))
		game.addVisual(new Salud(position=game.at(13,5),image = 'botiquin.png',aporta = 5))
		//game.addVisual(new Salud(position=game.at(0,8),image = 'botiquin.png',aporta = 5))
	//	game.addVisual(new Salud(position=game.at(11,1),image = 'botiquin.png',aporta = 5))
		game.addVisual(new Salud(position=game.at(5,13),image = 'botiquin.png',aporta = 5))
		
		game.addVisual(salud)
		game.addVisual(saludNum)
		game.addVisual(energia)
		game.addVisual(energiaNum)
		game.addVisual(dinero)
		game.addVisual(dineroNum)
		
		//celdas sorpresas 
		const celdaElementorRnd = new CeldaElementoRandom(image = 'pregunta.png',position = game.at(5,5),puntos=0)
		const celdaTeleport = new CeldaTeleport(image = 'pregunta.png',position = game.at(5,10),puntos=0)
		const celdaSumaEnergia = new CeldaEnergiaSuma(image = 'market.png', position = game.at(0,6), puntos = 30)
		const celdaRestaEnergia = new CeldaEnergiaResta(image = 'alien.png', position = game.at(1,1), puntos = 15)
		
		// ENEMIGOS
		const enemigoNormal1 = new EnemigoNormal(position = game.at(3,1), image="alien.png",nivelDanio = 3,direccion = izquierda)
		const enemigoNormal2 = new EnemigoNormal(position = game.at(5,9), image="alien.png",nivelDanio = 3,direccion = derecha)
		const enemigoNormal3 = new EnemigoNormal(position = game.at(8,0), image="alien.png",nivelDanio = 3,direccion = arriba)
		const enemigos = [enemigoNormal1, enemigoNormal2, enemigoNormal3]
		enemigos.forEach{e => self.dibujar(e)}
		enemigos.forEach{ e => game.whenCollideDo(e,{player => if(player.puedeRecibirDanio()){
			e.hacerDanio(player)
		}})}
		enemigos.forEach{ e => game.onTick(1000,"movimientoEnemigo",{
			if (e.seDesplazaNormal()){
				e.desplazarse()
			}else{
				e.desplazarseHacia(bubba)
			}})}
	
		// personaje, es importante que sea el último visual que se agregue
		game.addVisual(bubba)
		
		
		
		// teclado
		// este es para probar, no es necesario dejarlo
		keyboard.t().onPressDo({ self.terminar() })
		
		// Movimientos
		keyboard.up().onPressDo({ bubba.direccion(arriba) bubba.avanzar() })
		keyboard.down().onPressDo({ bubba.direccion(abajo) bubba.avanzar() })
		keyboard.left().onPressDo({ bubba.direccion(izquierda) bubba.avanzar() })
		keyboard.right().onPressDo({ bubba.direccion(derecha) bubba.avanzar() })
		keyboard.space().onPressDo({ bubba.comer()})		
		keyboard.any().onPressDo{ self.comprobarSiGano(estrellas, llaves) }
		keyboard.any().onPressDo{ if (self.estaTodoEnDeposito(estrellas, llaves)) {
			estrellas.forEach{e => game.removeVisual(e)}
			llaves.forEach{l => game.removeVisual(l)}
			deposito1.forEach{d => game.removeVisual(d)}
			game.addVisual(depositoCompleto)
		} }
				
		// en este no hacen falta colisiones
		game.whenCollideDo(bubba, { elemento => bubba.empujar(elemento)})
		
		
	//CELDA SORPRESA:
		const celdasSorpresas = [celdaElementorRnd,celdaTeleport, celdaSumaEnergia, celdaRestaEnergia]
		celdasSorpresas.forEach{ c => self.dibujar(c)}
		/*game.addVisual(celdaTeleport)
		game.addVisual(celdaElementorRnd)
		game.addVisual(celdaSumaEnergia)
		game.addVisual(celdaRestaEnergia)*/
		
		celdasSorpresas.forEach{ e => game.whenCollideDo(e,{player => if(player.puedeRecibirDanio()){e.afectar(player)}})}
		
			
		game.addVisual(deposito1)
		game.addVisual(estrellas)
		game.addVisual(llaves)
	
	}	
		
	method dibujar(dibujo) {
		game.addVisual(dibujo)
		return dibujo
	}
	
	method estaTodoEnDeposito(elem1, elem2) {
		return elem1.all{ c => c.estaBienPosicionada() } and elem2.all{ c => c.estaBienPosicionada() }
	}
	
	method comprobarSiGano(elem1,elem2) {
		if (elem1.all{ c => c.estaBienPosicionada() } and elem2.all{ c => c.estaBienPosicionada() }) {
			self.ganar() 
		}
	}
	method ganar(){
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(position = game.at(0,0),image="ganador.png"))
		
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="nivel2.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// ... limpio todo de nuevo
				game.clear()
				nivelLlaves.configurate()
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
			
			niveles.configurate()
			   
			
		})
	}
	
	
	method terminar() {
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(image="fondo.png"))
		// después de un ratito ...
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="nivel2.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// ... limpio todo de nuevo
				game.clear()
				// y arranco el siguiente nivel
				nivelLlaves.configurate()
			})
		})
	}
		
}
