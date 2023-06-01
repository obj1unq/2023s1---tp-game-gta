import wollok.game.*
import posiciones.*
import escenario.*
import vidas.*
import crash.*

object aguaFactory {	
	method nuevo() {
		return new Agua (danio = 20)
	}
}

object lavaFactory {
	method nuevo() {
		return new Lava(danio=40)
	}
}

object escalonFactory {
	method nuevo() {
		return new Obstaculo(image="ladrillo-pared.png")
	}
}

object enemigoFactory {
	method nuevo() {
		return new Enemigo(image="enemigo.png")
	}
}


object obstaculosManager {
	
	//const generados = #{}
	const limite = 3 // limite segun nivel?
	const obstaculosFactory = [lavaFactory, aguaFactory, escalonFactory, enemigoFactory]
	
	method generar() {
//		if(generados.size() < limite) {
			const obstaculo = self.nuevoObstaculo()	
			//game.addVisual(obstaculo)
			obstaculo.addToGame()
//			generados.add(obstaculo)
			escenario.agregarElemento(obstaculo)
//		}
	}
	
	method elegirFactory() {
	     return obstaculosFactory.anyOne()  
	}

	method nuevoObstaculo() {
		return self.elegirFactory().nuevo()
	}
}

class Obstaculo {
	
	 var property position  = positionFija.sobreElPiso()
	 var property danio = 0
	 var property image

	 method chocar(personaje) {
		personaje.restarVida(self.danio())
	}
	
	method addToGame(){
		game.addVisual(self)
	}
}

class ObstaculoSuelo inherits Obstaculo (position=positionFija.nivelDelPiso()){
	override method addToGame(){
		super()
		const colisionador = new ColisionadorSuelos(colisionado= self)
		game.addVisual(colisionador)
	}
}

class Agua inherits ObstaculoSuelo (image="agua.png") {}

class Lava inherits ObstaculoSuelo (image="lava1.png") {}

class ColisionadorSuelos {
	var colisionado
	method position() = colisionado.position().up(1)
	method chocar(personaje) {
		colisionado.chocar(personaje)
	}
}

class Enemigo inherits Obstaculo {
	
	override method image() = "enemigo.png"
	
	override method danio() = 30

	method serEliminado() {
		//game.removeVisual(self)
		//generados.remove(self)
	}
}