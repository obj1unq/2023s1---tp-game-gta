import wollok.game.*
import crash.*
import posiciones.*
import escenario.*
import vidas1.*
import efectos.*

//********* generadores de cajas *********************
object cajaBombaFactory {
	method nuevo() {
		return new CajaBomba()
	}
}
object cajaVidaFactory {
	method nuevo() {
		return new CajaVida()
	}
}

object cajaManzanaFactory {
	method nuevo() {
		return new CajaManzana()
	}
}

//********** manejador visual de cajas ***************
object cajaManager {
	const property cajasFactories = #{cajaBombaFactory, cajaVidaFactory, cajaManzanaFactory}
	
	
	method randomFactory() {
		const factories = cajasFactories.asList()
	    return factories.anyOne()
	}
	
	method nuevaCaja() {
		return self.randomFactory().nuevo()
	}
	
	method generar(){
		const caja = self.nuevaCaja()
		game.addVisual(caja)
		caidaManager.aplicarGravedad(caja)
	}
}
//************ Cajas **********************************

class Caja{
	
	var property position = positionRandomizer.cajas()
	
	method image()
	
	method consecuenciaChoque()
	
	method chocar(personaje){
		efectosColision.colisionar(self)
	}
	
	method esParedColisionada() = false
	
}

class CajaBomba inherits Caja {
	method danio() = 100
	override method image() = "caja-bomba.png"
	
	override method consecuenciaChoque() = explosivo
	
	override method chocar(personaje){
		super(personaje)
		personaje.restarVida(self.danio())
	}
}


class CajaBonus inherits Caja {
	method cantidadBonus()
	override method image() = "caja.png"
	
	
    override method chocar(personaje){
    	super(personaje)
    	personaje.sumarVida(self.cantidadBonus())
    }	
}

class CajaVida inherits CajaBonus {
	override method cantidadBonus() = 100
	
	override method consecuenciaChoque() = corazon
}

class CajaManzana inherits CajaBonus {
	override method cantidadBonus() = 250
	
	override method consecuenciaChoque() = manzana
}

//************ CAIDA ******************
object caidaManager{
	
	method acercarACrash(cosa){
		escenario.avanzar(cosa)
	}
	
	method aplicarGravedad(cosa){
		game.onTick(300, "CAIDA", {self.caer(cosa)})
	}
	
	method hayLugarDebajo(cosa){
		return cosa.position().y() > positionPiso.alturaDelPiso()
	}
	
	method bajar(cosa){
		cosa.position(cosa.position().down(1))
	}
	
	method caer(cosa){
		if(self.hayLugarDebajo(cosa)) {
			self.bajar(cosa)
		} else {
			self.acercarACrash(cosa)
		}
	}
}