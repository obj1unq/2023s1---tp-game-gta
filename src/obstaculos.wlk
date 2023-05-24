import wollok.game.*
import posiciones.*
import escenario.*

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
	method debilitar(){}// como sacarle porcentaje de vida a crash?
}

class ObstaculoPiso inherits Obstaculo {
	var property position  = positionFija.nivelDelPiso()
}

class ObstaculoSobrePiso inherits Obstaculo {
	var property position  = positionFija.sobreElPiso()
}

class Agua inherits ObstaculoPiso {
	const property image = "agua.png"	
}

class Lava inherits ObstaculoPiso {
	const property image = "lava1.png"
}

class Escalon inherits ObstaculoSobrePiso {
	const property image = "ladrillo-pared.png"
}

class Enemigo inherits ObstaculoSobrePiso {
	var property image = "enemigo.png"
	
	method serEliminado() {
		//game.removeVisual(self)
		//generados.remove(self)
	}
}
