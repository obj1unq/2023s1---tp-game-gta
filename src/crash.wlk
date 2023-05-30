import wollok.game.*
import vidas.*
import estados.*

object crash {
	const posicionInicial = game.at(1, 2)
	const posicionSalto = game.at(1, 5)
	var property position = posicionInicial
	var property image = "crash-1.png"
	var vida = 100  // 4 objetos vidas en collection?
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
		if (game.hasVisual(saltando)) {
			game.say(self, "Ya estoy saltando!")
		}
	}
	method saltar() {
		// self.validarSalto() --> como solucionarlo?
		self.salto()
		game.schedule(290, {self.estadoInicial()})
	}
	
	method vida() {
		return vida
	}
	
	method sumarVida(cantidad) {
		//validacion
		 vida =+ cantidad
		 game.say(self, "Estoy fortaleciendome")
	}
	
	method restarVida(cantidad) {
		//validacion
		 vida =- cantidad
		 game.say(self, "Estoy debilitandome")
	}
}