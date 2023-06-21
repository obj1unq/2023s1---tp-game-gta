import wollok.game.*
import vidas.*
import estados.*
import screens.*

object crash {
	const posicionInicial = game.at(1, 2)
	const posicionSalto = game.at(1, 5)
	var property position = posicionInicial
	var property image = "crash-1.png"
	const property vida = new Vida()// 4 objetos vidas en collection?
	var property estadoActual = reposo
	
	method salto() {
		game.removeTickEvent("CORRER")
		self.position(posicionSalto)
		self.image(saltando.image())
	}
	
	method estadoInicial() {
		self.position(posicionInicial)
		self.correr()
	}
		
	method cambiarEstado() {
		estadoActual = estadoActual.proximo()
		self.image(estadoActual.image())
	}
	
	method correr() {
			game.onTick(100, "CORRER", {self.cambiarEstado()})
	}
	
	method validarSalto(){
		if (game.hasVisual(saltando)) { //--> si la y no es 0?
			game.say(messagePoint, "Ya estoy saltando!")
		}
	}
	method saltar() {
		// self.validarSalto() --> como solucionarlo? 
		self.salto()
		game.schedule(500, {self.estadoInicial()})
	}
	
	method validarQuePuedoFortalecer(cantidad){
		if (self.vida().contador() == 100){
			game.say(messagePoint, "estoy lleno")
		}
	}
		
	method sumarVida(cantidad) {
		self.validarQuePuedoFortalecer(cantidad)
		self.vida().fortalecer(cantidad)
		game.say(messagePoint, "Yay!")
	}
	
	method validarQuePuedoDebilitar(cantidad){
		if (self.vida().contador() == 0){
			game.say(messagePoint,"ya estoy muerto")
			//myScreen.endGame()
		}
	}

	method restarVida(cantidad) {
		self.validarQuePuedoDebilitar(cantidad)
		self.vida().debilitar(cantidad)
		 game.say(messagePoint, "Auch!") 
	}
}



object messagePoint {
	method image() = 'empty.png'
	method position() = game.at(1, 3)
}

