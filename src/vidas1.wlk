import wollok.game.*
import crash.*
import estados.*

object muerto {
	method nombre() = "muerto"
	method tope() = 0.01
}

object agonia {
	method nombre() = "agonia"
	method tope() = 0.2
}

object peligroModerado {
	method nombre() = "peligroModerado"
	method tope() = 0.4
}

object peligroLeve {
	method nombre() = "peligroLeve"
	method tope() = 0.6
}

object menosSaludable {
	method nombre() = "menosSaludable"
	method tope() = 0.8
}

object saludable {
	method nombre() = "saludable"
	method tope() = 1
}
///////////////////////////////////////////////////
object lifeBar {
	
	const rangos = [muerto, agonia, peligroModerado, peligroLeve, menosSaludable, saludable]
	
	const totalVida = crash.vida().total()
	var property currentBar = saludable
	
	method image() = currentBar.nombre() + ".png"
	method position() = game.at(8, 13)
	
	method porcentajeVida(nroVida) {
		return nroVida / totalVida //si lo redondeo?
	}
	
	method closerTo(nroVida){
		const porcentaje = self.porcentajeVida(nroVida)
		return rangos.min({rango => (rango.tope() - porcentaje).abs()})//el % tope del que esta mas cerca
	}
	
	method actualizarBarraPara(nroVida){
		currentBar = self.closerTo(nroVida)
	}
		
//	method estaEnRango(nroVida){
//		const porcentaje = self.porcentajeVida(nroVida)
//		return porcentaje.between(currentBar.minimo(), currentBar.maximo())
//	}
//	
//	method cambiarRango(nroVida){
//		if (nroVida < currentBar.minimo() ){
//			currentBar.anterior().nombre()
//		} else currentBar.siguiente().nombre()
//	}
//	
//	method actualizarBarraPara(nroVida){
//		if (not self.estaEnRango(nroVida)){			
//			self.cambiarRango(nroVida)
//		}
//	}
		
//	method rangoEnQueSeEncuentra(valor){
//		ptjeValor.max(topeRango)
//	}
}

class Vida {
	var contador = 1000
	
	method total() = 1000
	
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









