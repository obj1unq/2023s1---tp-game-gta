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
		game.schedule(800, {self.estadoInicial()})
	}
	
	method puedoFortalecer() {
		return self.vida().contador() < 1000
	}
	
	method sumarVida(cantidad) {
		if (self.puedoFortalecer()) {
			self.vida().fortalecer(cantidad)
			game.say(messagePoint, "Yay!")
		}
	}

	method estaMuerto() {
		return self.vida().contador() == 0
	}
	
	method restarVida(cantidad) {
		if (not self.estaMuerto()) {
		 	game.say(messagePoint, "Auch!")
			self.vida().debilitar(cantidad)
		}
	}
	
	method morirSiCorresponde(){
		if (self.estaMuerto()){
			self.dejarDeCorrer()
			myScreen.gameOver()
		}
	}
	
	method dejarDeCorrer(){
		image = muerte.image()
		game.removeTickEvent("CORRER")
	}
	
}



object messagePoint {
	method image() = 'empty.png'
	method position() = game.at(1, 3)
}

