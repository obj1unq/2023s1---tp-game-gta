import wollok.game.*
import vida.*

object crash {
	const posicionInicial = game.at(1,2)
	const posicionSalto = game.at(1, 5)
	var property position = posicionInicial
	var property image = "crash.png"
	const property vidas = #{}
	
	method salto() {
		self.position(posicionSalto)
		self.image("jump-right.png")
	}
	
	method estadoInicial() {
		self.position(posicionInicial)
		self.image("crash.png")
	}
	
	method saltar() {
		self.salto()
		game.schedule(250, {self.estadoInicial()})
	}
	
	method restarVida(cantidad) {
		// validacion
		vida.restarA(self, cantidad)
	}
	
	method sumarVida(cantidad) {
		vida.sumarA(self, cantidad)
	}	
}