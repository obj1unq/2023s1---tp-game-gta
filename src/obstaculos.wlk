import wollok.game.*
import posiciones.*
import escenario.*
import vidas.*
import crash.*

// #{agua, lava, escalon, enemigo}  //cajaConBomba


object aguaFactory {
	
	method nuevo() {
		return new Agua()
	}
}

object lavaFactory {
	
	method nuevo() {
		return new Lava()
	}
}

object escalonFactory {
	
	method nuevo() {
		return new Escalon()
	}
}

object enemigoFactory {
	
	method nuevo() {
		return new Enemigo()
	}
}


object obstaculosManager {
	
	const generados = #{}
	const limite = 3 // limite segun nivel?
	const obstaculosFactory = [lavaFactory, aguaFactory, escalonFactory, enemigoFactory]
	
	method generar() {
//		if(generados.size() < limite) {
			const obstaculo = self.nuevoObstaculo()	
			game.addVisual(obstaculo)
//			generados.add(obstaculo)
			escenario.agregarElemento(obstaculo)
//		}
	}
	
	method elegirFactory() {
	     return obstaculosFactory.anyOne()  
	}

	method nuevoObstaculo() {
		return self.elegirFactory().nuevo()
	}

	
}
class Obstaculo {
	
	 method danio() { return 0 }

	 method chocar(personaje) {
		vidaManager.debilitar(personaje, self.danio())
	}
}

class ObstaculoPiso inherits Obstaculo {
	
	var property position  = positionFija.nivelDelPiso()
	
	override method chocar(personaje) {
		if (self.validarColision(personaje)) {
			super(personaje)
		}
	}
	
	method celdaArriba() {
		const nuevaY = self.position().y() + 1
		return game.at(self.position().x(), nuevaY)
	}
	
	method validarColision(personaje) {
		return game.getObjectsIn(self.celdaArriba()).contains(personaje)
	}
}

class ObstaculoSobrePiso inherits Obstaculo {
	
	var property position  = positionFija.sobreElPiso()
	
}

class Agua inherits ObstaculoPiso {
	
	const property image = "agua.png"	
	
	override method danio() = 20
}

class Lava inherits ObstaculoPiso {
	
	const property image = "lava1.png"
	
	override method danio() = 40
}

class Escalon inherits ObstaculoSobrePiso {
	
	const property image = "ladrillo-pared.png"

}

class Enemigo inherits ObstaculoSobrePiso {
	
	var property image = "enemigo.png"
	
	override method danio() = 30

	method serEliminado() {
		//game.removeVisual(self)
		//generados.remove(self)
	}
}
