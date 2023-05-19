object randomizer {
	
	const cajasFactories = #{cajaBombaFactory, cajaVidaFactory, cajaManzanaFactory}
	
	method newPositionAhead(personaje){ //problema: podrian haber varias cosas en la misma celda en el segundo intento? 
		const nuevaX = (personaje.x() .. game.width()).anyOne()
		const nuevaY = (personaje.y() .. game.height()).anyOne()
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