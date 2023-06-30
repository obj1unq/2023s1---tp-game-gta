import wollok.game.*
import vidas1.*
import estados.*
import screens.*
import efectos.*

object crash {
	var property estadoActual = reposo
	var property position = estadoActual.position()
	var property image = estadoActual.image()
	const property vida = vidaCrash
	
	method salto() {
		game.removeTickEvent("CORRER")
		estadoActual = saltando
		self.actualizarEstado()
	}
		
	method cambiarAProximoEstado() {
		estadoActual = estadoActual.proximo()
		self.actualizarEstado()
	}
	
	method actualizarEstado(){
		self.image(estadoActual.image())
		self.position(estadoActual.position())
	}
	
	method correr() {
			game.onTick(100, "CORRER", {self.cambiarAProximoEstado()})
	}
	
	method validarSalto(){
		if (self.position() == saltando.position()) {
			throw new Exception(message ="Ya estoy saltando!")
		}
	}
	
	method saltar() {
		self.validarSalto() 
		self.salto()
		game.schedule(800, {self.correr()})
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

	method sinVida() {
		return self.vida().contador() == 0
	}
	
	method restarVida(cantidad) {
		if (not self.sinVida()) {
		 	game.say(messagePoint, "Auch!")
			self.vida().debilitar(cantidad)
		}
	}
	
	method morirSiCorresponde(){
		if (self.sinVida()){
			self.morir()
		}
	}
	
	method morir(){
		estadoActual = muerte
		self.dejarDeCorrer()
		myScreen.gameOver()
	}
	
	method dejarDeCorrer(){
		self.actualizarEstado()
		game.removeTickEvent("CORRER")
	}
	
	method frenarPorPared() {
		game.say(messagePoint, "Debo saltar la pared")
	}
}

//----------------------------------------------------------------
object messagePoint {
	method image() = 'empty.png'
	method position() = crash.position().up(1)
}

