import wollok.game.*

object utilidades {
	method posRandom() {
		return game.at(
			0.randomUpTo(game.width()).truncate(0), 0.randomUpTo(game.height()-2).truncate(0)
		)
	}
	
	method randomX() {
		
		return 1.randomUpTo(game.width()).truncate(0)
	}
	
	method randomY() {
		return 2.randomUpTo(game.height()-2).truncate(0)
	}
}

