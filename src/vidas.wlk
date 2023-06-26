import wollok.game.*
import crash.*
import estados.*

class HealthBar {
	
	method image()
	method position() = game.at(8, 13)
	
	method minimo()
	method minimoRelativo() = self.minimo()
	method maximo()
	
	method actualizar(valor, estado){
		if (not self.estaEnEsteRango(valor)){
			self.cambiarRango(valor, estado)
		}
	}
	
	method estaEnEsteRango(valor){
		return valor.between(self.minimo(), self.maximo())
	}
	
	method cambiarRango(valor, estado){
		if (valor < self.minimoRelativo() ){
			lifeBar.currentBar(estado.anterior())
		} else lifeBar.currentBar(estado.siguiente())
	}
	
//	method rangoCorrespondiente(valor){
//		if (valor < self.minimoRelativo() ){
//			return self.anterior()
//		} else return self.siguiente()
//	}
//	
//	method nuevoEstado(valor){
//		if (self.estaEnEsteRango(valor)){
//			return self // FALLA EN ESTE CASO
//		} else return self.rangoCorrespondiente(valor)
//	}
}

object saludable inherits HealthBar {
	override method image() = "saludable.png"
	override method minimo() = 800
	override method maximo() = 1000
	method anterior() = menosSaludable
	
	override method cambiarRango(valor, estado){
		if (valor < self.minimoRelativo() ){
			lifeBar.currentBar(estado.anterior())
		}
	}

}

object menosSaludable inherits HealthBar {
	override method image() = "menosSaludable.png"
	override method minimo() = 600
	override method maximo() = 799
	method anterior() = peligroLeve
    method siguiente() = saludable
}

object peligroLeve inherits HealthBar {
	override method image() = "peligroLeve.png"
	override method minimo() = 400
	override method maximo() = 599
	method anterior() = peligroModerado
	method siguiente() = menosSaludable
}

object peligroModerado inherits HealthBar {
	override method image() = "peligroModerado.png"
	override method minimo() = 200
	override method maximo() = 399
	method anterior() = agonia
	method siguiente() = peligroLeve
}

object agonia inherits HealthBar {
	override method image() = "agonia.png"
	override method minimo() = 1
	override method maximo() = 199
	method anterior() = muerto
	method siguiente() = peligroModerado
}

object muerto inherits HealthBar {
	override method image() = "muerto.png"
	override method minimo() = 0
	override method minimoRelativo() = 1
	override method maximo() = 0
	method siguiente() = agonia
	
	override method cambiarRango(valor, estado){
		if (valor > self.maximo() ){
			lifeBar.currentBar(estado.siguiente())
		}
	}
}

//--- Barra de Vida

//La progresión es:
// saludable (800 a 1000)
// menosSaludable (600 a 799)
// peligroLeve (400 a 599)
// peligroModerado (200 a 399)
// agonia (1 a 199)
// muerto (0)

object lifeBar {
		
	var property currentBar = saludable
	
	method image() = currentBar.image()
	method position() = currentBar.position()
	
	
	method actualizarBarraPara(valor){
		
		currentBar.actualizar(valor, currentBar)
		//currentBar = currentBar.nuevoEstado(valor)
	}
}

class Vida {
	var contador = 1000
	
	method contador() = contador
	
	method fortalecer(cantidad) {
		
	 	contador = (contador + cantidad).min(1000)
	 	lifeBar.actualizarBarraPara(contador)
		
	}
	 
	method debilitar(cantidad) {
		
	 	contador = (contador - cantidad).max(0)
	 	lifeBar.actualizarBarraPara(contador)
	 	crash.morirSiCorresponde()	 	
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









