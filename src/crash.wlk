import wollok.game.*
import vida.*

object crash {
	const posicionInicial = game.at(1,1)
	const posicionSalto = game.at(1, 4)
	var property position = posicionInicial

	method image() = "crash.png"
	
	method saltar() {
		self.position(posicionSalto)
	//	game.onTick(100, "SALTO", {self.position(posicionInicial)})
	}
	
	method restarVida(cantidad) {
		// validacion
		vida.restarA(self, cantidad)
	}
	
	method sumarVida(cantidad) {
		vida.sumarA(self, cantidad)
	}	
}