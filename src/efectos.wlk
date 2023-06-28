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
		game.schedule(100, {cosa.consecuenciaChoque().sonar() })
		game.schedule(700, {game.removeVisual(cosa.consecuenciaChoque())})
	}
}

class EfectoSonoro {
	
	var property sound
	
	method sonar() {
		self.sound().play()
	}
	
	method stop() {
		self.sound().stop()
	}
	
}

object salpicadura inherits EfectoSonoro (sound = game.sound("water-splash.wav")) {
	method image() = "waterSplash.png"
	method altura() = 2
//	method sound() = game.sound("water-splash.wav")
}

object fuego inherits EfectoSonoro (sound = game.sound("fireBurning.mp3")) {
	method image() = "fuego.png"
	method altura() = 2
//	method sound() = game.sound("fireBurning.mp3")
}

object explosivo inherits EfectoSonoro (sound = game.sound("fuelExplosion.mp3")) {
	method image() = "explosion.png"
	method altura() = 1
//	method sound() = game.sound("fuelExplosion.mp3")
}

object corazon inherits EfectoSonoro (sound = game.sound("instant-win.wav")) {
	method image() = "corazon.png"
	method altura() = 4
//	method sound() = game.sound("instant-win.wav")
}

object manzana inherits EfectoSonoro (sound = game.sound("instant-win.wav")) {
	method image() = "manzana.png"
	method altura() = 4
//	method sound() = game.sound("instant-win.wav")
}

object grunido inherits EfectoSonoro (sound = game.sound("snarl.mp3")) {
	method image() = "paw.png"
	method altura() = 1
//	method sound() = game.sound("snarl.mp3")
}

object drNeoCortex inherits EfectoSonoro (sound = game.sound("evil-laugh.mp3")) {
	method image() = "neoCortex.png"
	method position() = game.at(8,6)
//	method sound() = game.sound("evil-laugh.mp3")
	
	method vanagloriarse(){
		game.addVisual(self)
		self.sound().play()
	}
}