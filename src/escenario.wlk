import wollok.game.*
import posiciones.*
import obstaculos.*


class Nube {
	var property altura = 5
	var property position = game.at(12,self.altura())	
	method image() {
		return "nube.png"
	}
	
	method esParedColisionada() = false

}

object nubeManager {
	
	method nuevo(_position){
		return new Nube(altura= _position.y(), position= _position)
	}
	
	method generar(){
			const nube = self.nuevo(positionRandomizer.nube())
			game.addVisual(nube)
			escenario.agregarElemento(nube)
	}
}


object escenario{
	var property elementosCreados = []
	
	method agregarElemento(cosa){
		self.elementosCreados().add(cosa)
	}
		
	method avanzar(cosa){
		if (not cosa.esParedColisionada()) {
			const nuevoX= cosa.position().x()-1
		cosa.position(game.at(nuevoX, cosa.position().y()))
		}
	}
	
	method avanzarEscenario(){
		self.elementosCreados().forEach{elemento => self.avanzar(elemento)}
	}
}
