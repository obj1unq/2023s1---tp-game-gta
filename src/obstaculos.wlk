import wollok.game.*

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
	const obstaculos = [lavaFactory, aguaFactory, escalonFactory, enemigoFactory]
	
	method generar() {
//		if(generados.size() < limite) {
			const obstaculo = self.nuevoObstaculo()	
			game.addVisual(obstaculo)
//			generados.add(obstaculo)
//		}
	}
	
	method elegirFactory() {
	     return obstaculos.anyOne()  
	}

	method nuevoObstaculo() {
		return self.elegirFactory().nuevo()
	}
	
}
class Obstaculo {
	
	method aparecer() {}
	
	method debilitar() {
		
		// como sacarle porcentaje de vida a crash?
	}
}

class Agua inherits Obstaculo {
	var property position = game.at(game.width() - 2 , 1)
	var property image = "agua.png"
	
	
}

class Lava inherits Obstaculo {
	var property position = game.at(game.width() - 1 , 1)
	var property image = "lava1.png"
	
}


class Escalon inherits Obstaculo {
	var property position = game.at(game.width() - 2 , 2)
	var property image = "ladrillo-pared.png"
	
}


class Enemigo inherits Obstaculo {
	var property position = game.at(game.width() - 1 , 2)
	var property image = "enemigo.png"
	
	method serEliminado() {
		//game.removeVisual(self)
		//generados.remove(self)
	}
}
