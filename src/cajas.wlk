import wollok.game.*
import crash.*
import posiciones.*
import escenario.*
import vidas1.*
//********* generadores de cajas *********************
object cajaBombaFactory {
	method nuevo() {
		return new CajaBomba(position = positionRandomizer.bonus())
	}
}
object cajaVidaFactory {
	method nuevo() {
		return new CajaVida(position = positionRandomizer.bonus())
	}
}

object cajaManzanaFactory {
	method nuevo() {
		return new CajaManzana(position = positionRandomizer.bonus())
	}
}

//********** manejador visual de cajas ***************
object cajaManager {
	const cajasFactories = [cajaBombaFactory,cajaVidaFactory,cajaManzanaFactory]
	
	method elegirFactory() {
	     return cajasFactories.anyOne()  
	}
	
	method generar(){
		const caja = self.nuevaCaja()
		game.addVisual(caja)
		caidaManager.aplicarGravedad(caja)
	}
	
	method eliminar(caja){
		game.removeVisual(caja)
	}
	
	method nuevaCaja() {
		return self.elegirFactory().nuevo()
	}
}
//************ Cajas **********************************

class Caja{
	//const probabilidadAparicion = 0
	
	var property position
	method image()
	method chocar(personaje){//es correcto parametrizar al personaje o pasarlo como atributo?
		//validar colision
		//personaje.agarrar(self)
		//cajaManager.eliminar(self)
	}
	
	method esPared() = false
}

class CajaBomba inherits Caja {
	method danio() = 30
	override method image() = "caja-bomba.png"
	
	override method chocar(personaje){
		super(personaje)
		personaje.restarVida(self.danio())
//		game.say(messagePoint, "perdí una vida!")
	}
}


class CajaBonus inherits Caja {
	method contenido()
	override method image() = "caja.png"
	
	
    override method chocar(personaje){
    	super(personaje)
    	personaje.sumarVida(self.contenido().cantidad())
//		game.say(messagePoint, "vida extra!")
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
    method cantidad() = 100
}

object bonusManzana {
	method cantidad() = 250
}

//************ CAIDA ******************
object caidaManager{
	
	method acercarAOrigen(cosa){
		escenario.avanzar(cosa)
	}
	
	method aplicarGravedad(cosa){
		game.onTick(300, "CAIDA", {self.caer(cosa)})
	}
	
	method hayLugarDebajo(cosa){
		return cosa.position().y() > 2
	}
	
	method caer(cosa){
		if(self.hayLugarDebajo(cosa)) {			
			cosa.position(game.at(cosa.position().x(), cosa.position().y() - 1 ))
		} else {
			self.acercarAOrigen(cosa)
		}
	}
}