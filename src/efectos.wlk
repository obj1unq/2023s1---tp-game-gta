import wollok.game.*
import posiciones.*
import escenario.*
import vidas1.*
import crash.*

object efectosColision {
	
	method nuevaPosicion(cosa,efecto){
		return cosa.position().up(efecto.altura()).right(1)
	}
	
	method reemplazar(cosa, efecto){
		game.addVisualIn(efecto, self.nuevaPosicion(cosa,efecto))
		game.removeVisual(cosa)
	}
	
	method colisionar(cosa){
		self.reemplazar(cosa, cosa.consecuenciaChoque())
		//TODO: se puede agregar sonido
		game.schedule(700, {game.removeVisual(cosa.consecuenciaChoque())})
	}
}

object salpicadura {
	method image() = "waterSplash.png"
	method altura() = 2
	//method sonido() =
}

object fuego {
	method image() = "fuego.png"
	method altura() = 2
}

object explosivo {
	method image() = "explosion.png"
	method altura() = 1
}

object corazon {
	method image() = "corazon.png"
	method altura() = 4
}

object manzana {
	method image() = "manzana.png"
	method altura() = 4
}

object drNeoCortex {
	method image() = "neoCortex.png"
	method position() = game.at(8,6)
	
	method vanagloriarse(){
		game.addVisual(self)
		// TODO: agragar risa malvada (?
	}
}