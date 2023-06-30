import wollok.game.*

object efectosColision {
	
	method posicionDelEfecto(cosa,efecto){
		return cosa.position().up(efecto.altura()).right(1)
	}
	
	method reemplazarPor(causa, efecto){
		const posicionDelEfecto =  self.posicionDelEfecto(causa,efecto)
		game.removeVisual(causa)
		game.addVisualIn(efecto, posicionDelEfecto)
	}
	
	method colisionar(cosa){
		self.reemplazarPor(cosa, cosa.consecuenciaChoque())
		game.schedule(100, {cosa.consecuenciaChoque().sonar()})
		game.schedule(700, {game.removeVisual(cosa.consecuenciaChoque())})
	}
}

// --- CONTROL DE SONIDO (PARA TEST) -------------

class EfectoSonoro {
	method image()
	method altura()
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

// --- CONSECUENCIAS DE CHOQUE ------

object salpicadura inherits EfectoSonoro {
	override method image() = "waterSplash.png"
	override method altura() = 2
    override method sound() = game.sound("water-splash.wav")
}

object fuego inherits EfectoSonoro {
	override method image() = "fuego.png"
	override method altura() = 2
	override method sound() = game.sound("fireBurning.mp3")
}

object explosivo inherits EfectoSonoro {
	override method image() = "explosion.png"
	override method altura() = 1
	override method sound() = game.sound("fuelExplosion.mp3")
}

object corazon inherits EfectoSonoro {
	override method image() = "corazon.png"
	override method altura() = 4
	override method sound() = game.sound("instant-win.wav")
}

object manzana inherits EfectoSonoro {
	override method image() = "manzana.png"
	override method altura() = 4
	override method sound() = game.sound("instant-win.wav")
}

object grunido inherits EfectoSonoro {
	override method image() = "paw.png"
	override method altura() = 0
	override method sound() = game.sound("snarl.mp3")
}

object drNeoCortex inherits EfectoSonoro {
	override method image() = "neoCortex.png"
	override method altura() = 0
	
	method position() = game.at(8,6)
	
	override method sound() = game.sound("evil-laugh.mp3")
	
	method vanagloriarse(){
		game.addVisual(self)
		self.sonar()
	}
}