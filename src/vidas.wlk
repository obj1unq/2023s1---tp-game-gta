import crash.*
import wollok.game.*

class Vida {
	var property contador = 100

	//var property personaje ??? o lo sabe solo quien la crea?
	
	method fortalecer(cantidad) {
	 	contador = (contador + cantidad).min(100)
	}
	 
	method debilitar(cantidad) {
	 	contador = (contador - cantidad).max(0)
	}
}

object displayVida{
	method position() {
		return game.at(2,10)
	}
	
	method text(){
		return crash.vida().contador().toString()
	}
	
	method textColor() = "000000ff" //rgb(00,00,00,00)
}





