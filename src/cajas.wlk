import wollok.game.*
import crash.*
import randomizer.*
//import vida.*
//********* generadores de cajas *********************
object cajaBombaFactory {
	method nuevo() {
		return new CajaBomba(position = randomizer.nextEmptyPosition(crash))
	}
}
object cajaVidaFactory {
	method nuevo() {
		return new CajaVida(position = randomizer.nextEmptyPosition(crash))
	}
}

object cajaManzanaFactory {
	method nuevo() {
		return new CajaManzana(position = randomizer.nextEmptyPosition(crash))
	}
}

//********** manejador visual de cajas ***************
// en el program voy a tener cada cierto tiempo un generar con maximo de 5
//cajaManager.generar(randomizer.randomCajaFactory())
object cajaManager { 
	method generar(factory){
		const caja = factory.nuevo()
		game.addVisual(caja)
	}
	
	method eliminar(caja){
		game.removeVisual(caja)
	}
}
//************ Cajas **********************************

class Caja{
	//const probabilidadAparicion = 0
	var property personaje = crash
	var property position
	method image()
	method afectar(personaje) //implementar
	
	
	method colisionar(personaje){} //implementar
	
	method serAgarradoPor(personaje){//es correcto parametrizar al personaje o pasarlo como atributo?
		//validar colision
		personaje.agarrar(self)
		cajaManager.eliminar(self)
		self.afectar(personaje)	
	}
}

class CajaBomba inherits Caja {
	override method image() = "caja-bomba.png"
	
	override method serAgarradoPor(personaje){
		super(personaje)
		game.say(personaje, "perdí una vida!")
		
	}
	override method afectar(personaje){
		vida.restarA(personaje,1)
	}
}


class CajaBonus inherits Caja {
	method contenido()
	override method image() = "caja.png"
	
	
	override method serAgarradoPor(personaje) {
		super(personaje)
		game.say(personaje, "vida extra!")
	}
	
	method darVida(personaje){
		vida.sumarA(personaje, self.contenido().cantidad())
	}
	
    override method afectar(personaje){
    	self.darVida(personaje)
    }	
}

class CajaVida inherits CajaBonus {
	override method contenido() = bonusVida
}

class CajaManzana inherits CajaBonus {
	override method contenido() = bonusManzana
}

//********** Bonus **********
object bonusVida {
    method cantidad() = 1
}

object bonusManzana {
	method cantidad() = 0.25
}