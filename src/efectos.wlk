import wollok.game.*
import posiciones.*
import escenario.*
import vidas1.*
import crash.*
import soundProducer.*

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
		game.schedule(100, {cosa.consecuenciaChoque().sonar() })
		game.schedule(700, {game.removeVisual(cosa.consecuenciaChoque())})
	}
}

class EfectoSonoro {
	
	method sound()
	
	method sonar() {
		if (controlDeSonido.habilitado()) {
			self.sound().play()
		}
	}
	
}

object controlDeSonido {
	
	var property habilitado = true
}

object salpicadura inherits EfectoSonoro {
	method image() = "waterSplash.png"
	method altura() = 2
    override method sound() = game.sound("water-splash.wav")
}

object fuego inherits EfectoSonoro {
	method image() = "fuego.png"
	method altura() = 2
	override method sound() = game.sound("fireBurning.mp3")
}

object explosivo inherits EfectoSonoro {
	method image() = "explosion.png"
	method altura() = 1
	override method sound() = game.sound("fuelExplosion.mp3")
}

object corazon inherits EfectoSonoro {
	method image() = "corazon.png"
	method altura() = 4
	override method sound() = game.sound("instant-win.wav")
}

object manzana inherits EfectoSonoro {
	method image() = "manzana.png"
	method altura() = 4
	override method sound() = game.sound("instant-win.wav")
}

object grunido inherits EfectoSonoro {
	method image() = "paw.png"
	method altura() = 0
	override method sound() = game.sound("snarl.mp3")
}

object drNeoCortex inherits EfectoSonoro {
	method image() = "neoCortex.png"
	method position() = game.at(8,6)
	override method sound() = game.sound("evil-laugh.mp3")
	
	method vanagloriarse(){
		game.addVisual(self)
		self.sonar()
	}
}