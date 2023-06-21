import wollok.game.*
import crash.*
import estados.*

object saludable {
	const property image = "saludable.png"
	method position() = game.at(3 ,12)
}

object menosSaludable {
	const property image = "menosSaludable.png"
	method position() = game.at(3 ,12)
}

object peligroLeve {
	const property image = "peligroLeve.png"
	method position() = game.at(3 ,12)
}

object peligroModerado {
	const property image = "peligroModerado.png"
	method position() = game.at(3 ,12)
}

object agonia {
	const property image = "agonia.png"
	method position() = game.at(3 ,12)
}

object muerto {
	const property image = "muerto.png"
	method position() = game.at(3 ,12)
}

//--- Barra de Vida

//La progresión es:
// saludable (100 a 80) - menosSaludable (79 a 60)
// peligroLeve (59 a 40)
// peligroModerado (39 a 20) - agonia (19 a 0)

object lifeBar {
	
	const rangos = [muerto, agonia, peligroModerado, peligroLeve, menosSaludable, saludable]
	
	var currentBar = saludable
	
	method image() = currentBar.image()
	method position() = currentBar.position()
	
//	method position() {
//		return game.at(3 ,12)
//	}
	
	method obtenerIndex(valor){
		return (valor / 100).truncate(0)
	}
	
	method barraDeRango(valor){
		const indice = self.obtenerIndex(valor)
		return rangos.get(indice) // me trae el obj que tiene ese rango
	}
	
	method addBarPara(valor){
		currentBar = valor
		game.addVisual(valor)
	}
	
	method estaElObjeto(bar) {
		return game.hasVisual(bar)
	}
	
	method removeBar(bar){ // TODO: revisar xq falla. Dice que no encuentra obj a remover
		if (self.estaElObjeto(bar)) {
			game.removeVisual(bar)
		} else throw new Exception(message = 'No esta')
		
	}
}

class Vida {
	var property contador = 500 //TODO: subirle el maximo a 500 para que dure mas
	var valorAnterior
	
	
	method fortalecer(cantidad) {
		valorAnterior = contador
	 	contador = (contador + cantidad).min(500)
	 	self.actualizarLifeBar(contador)
		
	}
	 
	method debilitar(cantidad) {
		valorAnterior = contador
	 	contador = (contador - cantidad).max(0)
	 	self.actualizarLifeBar(contador)
	 	
	}
	
	method actualizarLifeBar(valorNuevo){
		const rangoAnterior = lifeBar.barraDeRango(valorAnterior) 
		const rangoBuscado = lifeBar.barraDeRango(valorNuevo)
		//sigue en el mismo rango? sino que lo cambie
		if (rangoBuscado != rangoAnterior) {
			lifeBar.removeBar(rangoAnterior)
			lifeBar.addBarPara(rangoBuscado)
		} else throw new Exception(message = 'Es la misma')
		//obj barra visual

	}
}


// -------- VIDA DE CRASH ------------------

// --- Contador Numerico de la vida
object displayVidaCounter{
	method position() {
		return game.at(2 ,12)
	}
	
	method text(){
		return crash.vida().contador().toString()
	}
	
	method textColor() = "000000ff" //rgb(00,00,00,00)
}









