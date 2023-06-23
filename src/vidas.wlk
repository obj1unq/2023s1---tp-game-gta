import wollok.game.*
import crash.*
import estados.*

class HealthBar {
	
	method image()
	method position() = game.at(8, 13)
	
	method minimo()
	method minimoRelativo() = self.minimo()
	method maximo()
	
	method anterior()
	method siguiente()
	
	method estaEnEsteRango(valor){
		return valor.between(self.minimo(), self.maximo())
	}
	
	method rangoCorrespondiente(valor){
		if (valor < self.minimoRelativo() ){
			return self.anterior()
		} else return self.siguiente()
	}
	
	method nuevoEstado(valor){
		if (self.estaEnEsteRango(valor)){
			return self 
		} else return self.rangoCorrespondiente(valor)
	}
	//opcion: actualizar estado y mandarse a si mismo si corresponde
}

object saludable inherits HealthBar {
	override method image() = "saludable.png"
	override method minimo() = 800
	override method maximo() = 1000
	override method anterior() = menosSaludable
	override method siguiente() = self

}

object menosSaludable inherits HealthBar {
	override method image() = "menosSaludable.png"
	override method minimo() = 600
	override method maximo() = 799
	override method anterior() = peligroLeve
	override method siguiente() = saludable
}

object peligroLeve inherits HealthBar {
	override method image() = "peligroLeve.png"
	override method minimo() = 400
	override method maximo() = 599
	override method anterior() = peligroModerado
	override method siguiente() = menosSaludable
}

object peligroModerado inherits HealthBar {
	override method image() = "peligroModerado.png"
	override method minimo() = 200
	override method maximo() = 399
	override method anterior() = agonia
	override method siguiente() = peligroLeve
}

object agonia inherits HealthBar {
	override method image() = "agonia.png"
	override method minimo() = 1
	override method maximo() = 199
	override method anterior() = muerto
	override method siguiente() = peligroModerado
}

object muerto inherits HealthBar {
	override method image() = "muerto.png"
	override method minimo() = 0
	override method minimoRelativo() = 1
	override method maximo() = 0
	override method anterior() = self
	override method siguiente() = agonia
}

//--- Barra de Vida

//La progresión es:
// saludable (100 a 800) - menosSaludable (600 a 799)
// peligroLeve (400 a 599)
// peligroModerado (200 a 399) - agonia (1 a 199) - muerto (0)

object lifeBar {
		
	var currentBar = saludable
	
	method image() = currentBar.image()
	method position() = currentBar.position()
	
	
	method actualizarBarraPara(valor){
		currentBar = currentBar.nuevoEstado(valor)
	}
}

class Vida {
	var property contador = 1000
	
	method fortalecer(cantidad) {
		
	 	contador = (contador + cantidad).min(1000)
	 	lifeBar.actualizarBarraPara(contador)
		
	}
	 
	method debilitar(cantidad) {
		
	 	contador = (contador - cantidad).max(0)
	 	lifeBar.actualizarBarraPara(contador)
	 	
	}
}


// -------- VIDA DE CRASH ------------------

// --- Contador Numerico de la vida
object displayVidaCounter{
	method position() {
		return game.at( 7, 13)
	}
	
	method text(){
		return crash.vida().contador().toString()
	}
	
	method textColor() = "000000ff" //rgb(00,00,00,00)
}









