import wollok.game.*
import vidas.*
import estados.*

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
			game.say(self, "Ya estoy saltando!")
		}
	}
	method saltar() {
		// self.validarSalto() --> como solucionarlo? 
		self.salto()
		game.schedule(500, {self.estadoInicial()})
	}
	
	method validarQuePuedoFortalecer(cantidad){
		if (self.vida().contador() == 100){
			self.error("ya esta lleno de vida")
		}
	}
		
	method sumarVida(cantidad) {
		self.validarQuePuedoFortalecer(cantidad)
		self.vida().fortalecer(cantidad)//REVISAR XQ A VECES FALLA CON LAS CAJAS
		game.say(self, "Yay!")
	}
	
	method validarQuePuedoDebilitar(cantidad){
		if (self.vida().contador() == 0){
			self.error("ya estoy muerto")
		}
	}

	method restarVida(cantidad) {
		self.validarQuePuedoDebilitar(cantidad)
		self.vida().debilitar(cantidad)
		 game.say(self, "Auch!") 
	}
}





