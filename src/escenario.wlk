import wollok.game.*
import posiciones.*
//import obstaculos.*
//import cajas.*


class Nube {
	var property altura = 5
	var property position = game.at(12,self.altura())	
	method image() {
		return "nube.png"
	}
}

object nubeManager {
	//const property nubesGeneradas = []
	//const limite = 3 cómo controlar que haya solo 3 en pantalla? sino se puede setear un tiempo de espaciado grande
	
	method nuevo(_position){
		return new Nube(altura= _position.y(), position= _position)
	}
	
	method generar(){
			const nube = self.nueva(positionRandomizer.nube())
			game.addVisual(nube)
			//nubesGeneradas.add(nube)
			escenario.agregarElemento(nube)
	}
}


object escenario{
	var property elementosCreados = []
	
	method agregarElemento(cosa){
		self.elementosCreados().add(cosa)
	}
	
	method avanzar(cosa){
		const nuevoX= cosa.position().x()-1
		cosa.position(game.at(nuevoX, cosa.position().y()))
	}
	
	method avanzarEscenario(){
		self.elementosCreados().forEach{elemento => self.avanzar(elemento)}
	}
}
