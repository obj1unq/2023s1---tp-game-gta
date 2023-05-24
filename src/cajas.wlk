import wollok.game.*
import crash.*
import posiciones.*
import escenario.*
import vida.*
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
	var property personaje = crash
	var property position
	method image()
	method afectar(personaje) //implementar
	
	
	//method colisionar(personaje){} //implementar
	
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