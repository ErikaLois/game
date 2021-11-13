import personaje.*
import wollok.game.*

//object fondoMarcador{
//	var property position = game.at(0,game.height())
// 	method imagen() = 'fondoBlanco.png'
//}
object energia{
	var property position = game.at(1,game.height()-1)
	method image(){
		var img
		if(bubba.energia()>=21){
			img=   "bateriaCompleta.png"
		}if(bubba.energia().between(11,20)){
			img="bateriaMitad.png"
		}if(bubba.energia().between(0,10)){
			img="bateriaBaja.png"
		}
	return img}
}
object energiaNum{
	var property position = game.at(2,game.height()-1)
	method text()="  " +  bubba.energia()
}

object salud{
	var property position = game.at(4,game.height()-1)
	method image()= "salud.png "
}
object saludNum{
	var property position = game.at(5,game.height()-1)
	method text() = " " + bubba.salud()
}
object dinero{
	var property position = game.at(7,game.height()-1)
	method image()= "dinero.png "
}
object dineroNum{
	var property position = game.at(8,game.height()-1)
	method text() = "  " + bubba.dinero()
}

object municion{
	var property position = game.at(9,game.height()-1)
	method text() = "Municiones: " + bubba.municiones()
}