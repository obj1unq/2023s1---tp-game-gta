import wollok.game.*
import posiciones.*
import escenario.*
import vidas1.*
import crash.*
import sonidos.*

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
		//cosa.consecuenciaChoque().sound().play()
		game.schedule(700, {game.removeVisual(cosa.consecuenciaChoque())})
	}
}

object salpicadura {
	method image() = "waterSplash.png"
	method altura() = 2
	method sound() = waterSplash
}

object fuego {
	method image() = "fuego.png"
	method altura() = 2
	method sound() = burn
}

object explosivo {
	method image() = "explosion.png"
	method altura() = 1
	method sound() = tntExploding
}

object corazon {
	method image() = "corazon.png"
	method altura() = 4
	method sound() = bonus
}

object manzana {
	method image() = "manzana.png"
	method altura() = 4
	method sound() = bonus
}

object drNeoCortex {
	method image() = "neoCortex.png"
	method position() = game.at(8,6)
	
	method vanagloriarse(){
		game.addVisual(self)
		// TODO: agragar risa malvada (?
	}
}

//////////////////////////////////////////////
object splashSound {