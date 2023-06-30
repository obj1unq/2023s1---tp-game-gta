import wollok.game.*
import posiciones.*
import escenario.*
import vidas1.*
import crash.*
import efectos.*

object aguaFactory {	
	method nuevo() {
		return new Agua ()
	}
}

object lavaFactory {
	method nuevo() {
		return new Lava()
	}
}

object paredFactory {
	method nuevo() {
		return new Pared()
	}
}

object enemigoFactory {
	const images = ["beetle", "bird", "enemigo", "ghost", "ghost2", "monster"]
	
	method cualquierImagen(){
		return images.anyOne() + ".png"
	}
	
	method nuevo() {
		return new Enemigo(image = self.cualquierImagen())
	}
}


object obstaculosManager {
	
	var property obstaculosFactory = #{lavaFactory, aguaFactory, paredFactory, enemigoFactory}
	
	method generar() {
			const obstaculo = self.nuevoObstaculo()	
			obstaculo.addToGame()
			escenario.agregarElemento(obstaculo)
	}
	
	method nuevoObstaculo() {
		return self.elegirFactory().nuevo()
	}
	
	method elegirFactory() {
		const factories = obstaculosFactory.asList()
	    return factories.anyOne()  
	}
}

class Obstaculo {
	
	 var property position  = positionPiso.sobreElPiso()
	 var property danio = 0
	 var property image

	 method chocar(personaje) {
		personaje.restarVida(self.danio())
	}
	
	method addToGame(){
		game.addVisual(self)
	}
		
	method esParedColisionada() = false
}

class ObstaculoSuelo inherits Obstaculo (position=positionPiso.nivelDelPiso()){
	
	method consecuenciaChoque()
	
	override method addToGame(){
		super()
		const colisionador = new ColisionadorSuelos(colisionado= self)
		game.addVisual(colisionador)
	}
	
	override method chocar(personaje) {
		super(personaje)
		efectosColision.colisionar(self)
	}
}

class Agua inherits ObstaculoSuelo (image="agua.png", danio=200) {
	override method consecuenciaChoque() = salpicadura
}

class Lava inherits ObstaculoSuelo (image="lava1.png", danio=400) {
	override method consecuenciaChoque() = fuego
}

class ColisionadorSuelos {
	var colisionado
	method position() = colisionado.position().up(2)
	method chocar(personaje) {
		colisionado.chocar(personaje)
	}
}

class ColisionadorPared inherits ColisionadorSuelos {
	override method position() = colisionado.position().left(2)
	
}

class Enemigo inherits Obstaculo (danio=300) {
	
	method consecuenciaChoque() = grunido
	
	override method chocar(personaje) {
		super(personaje)
		efectosColision.colisionar(self)
	}
}

class Pared inherits Obstaculo (image="ladrillo-pared.png") {
	
	var colisionador = null
	
	override method addToGame() {
		super()
		colisionador = new ColisionadorPared(colisionado = self)
		game.addVisual(colisionador)
	}
	
	method noDejarAvanzar(personaje) {
		personaje.frenarPorPared()
	}
	
	override method chocar(personaje) {
		self.noDejarAvanzar(personaje)
	}
	
	override method esParedColisionada() {
		return game.colliders(colisionador).contains(crash)
	}
}


