import wollok.game.*
import crash.*

object timer {
	
	var tiempoJugado = 0
	var position = game.at(17, 13)
	
	method position() {
		return position
	}
	
	method contarSegundo(){
		if (not crash.sinVida()){			
			tiempoJugado++
		}
	}
	
	method text(){
		return "Tiempo Jugado: " + tiempoJugado.toString()
	}
	
	method textColor() = "000000ff"
	
	method addTiempoFinal(){
		position = game.at(10, 5)
		game.addVisual(self)
	}
}
