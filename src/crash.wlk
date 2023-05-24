import wollok.game.*
import vida.*
import estados.*

object crash {
	const posicionInicial = game.at(1,2)
	const posicionSalto = game.at(1, 5)
	var property position = posicionInicial
	var property image = "crash-1.png"
	const property vidas = #{}
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
	
	method restarVida(cantidad) {
		// validacion
		vida.restarA(self, cantidad)
	}
	
	method sumarVida(cantidad) {
		vida.sumarA(self, cantidad)
	}	
}