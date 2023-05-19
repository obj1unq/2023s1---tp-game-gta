import wollok.game.*
import cajas.*

object randomizer {
	
	const cajasFactories = #{cajaBombaFactory, cajaVidaFactory, cajaManzanaFactory}
	
	method newPositionAhead(personaje){ //problema: podrian haber varias cosas en la misma celda en el segundo intento? 
		const nuevaX = (personaje.position().x() .. game.width()-1).anyOne()
		const nuevaY = (personaje.position().y() .. game.height()-1).anyOne()
		return game.at(nuevaX, nuevaY)
	}
	
	method emptyPosition(position){
		return game.getObjectsIn(position) == #{}
	}
	
	method nextEmptyPosition(personaje){
		const posicionNueva = self.newPositionAhead(personaje)
		if(not self.emptyPosition(posicionNueva)){
			return self.newPositionAhead(personaje)
		} else return posicionNueva
	}
	
	method randomCajaFactory(){
		return cajasFactories.anyOne()
	}
}