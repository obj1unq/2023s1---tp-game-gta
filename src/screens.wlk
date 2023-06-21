import wollok.game.*
import crash.*
import escenario.*
import obstaculos.*
import cajas.*
import vidas.*


object myScreen {
	
	method configInicial() {
		//tablero
		game.title("Crash")
		game.height(15)
		game.width(21)
		
		game.addVisual(startScreen)
		
		//personajes y acciones
		
		keyboard.s().onPressDo{
			game.clear()
			self.addMainScreen()
			self.addEscenarioMovil()
			self.agregarComandos()
		}
	}
	
	method addMainScreen(){
			game.addVisual(mainScreen)
			game.addVisual(crash)
			game.addVisual(messagePoint)
			game.addVisual(displayVidaCounter)
			game.addVisual(lifeBar)
			crash.estadoInicial()
			game.errorReporter(displayVidaCounter)
	}
	
	method agregarComandos(){
		keyboard.space().onPressDo{crash.saltar()}
		
		//keyboard.p().onPressDo{pausedScreen.togglePausedScreen()} 
	
		keyboard.f().onPressDo{game.clear(); game.addVisual(lastScreen)}
		// esto es solo para probar. En realidad cambiara cuando se quede sin vida 
	}
	
	method addEscenarioMovil(){
		//escenario
		game.onTick (4000, "GENERAR_NUBES", {nubeManager.generar()})
		game.onTick (4000, "GENERAR_ELEMENTOS", {obstaculosManager.generar()})
		game.onTick(180, "AVANZAR_ESCENARIO", {escenario.avanzarEscenario()})
		game.onTick(7000, "GENERAR_CAJAS", {cajaManager.generar()})
		game.onCollideDo(crash, {objeto => objeto.chocar(crash)})
	}
	
	method endGame(){
		game.clear()
		game.addVisual(lastScreen)
	}
}

// ----------------------- PANTALLAS

class Screen {
	method image()
	method position() = game.origin()
}


object startScreen inherits Screen{
	override method image() = '2.jpg'		
}

object mainScreen inherits Screen{
	override method image() = '1.jpg'	
}

object pausedScreen inherits Screen {
	override method image() = 'pause.png'
	
	method togglePausedScreen(){
		if (not game.hasVisual(self)){
			game.addVisual(self)
			// DUDA: COMO DETENER AVANCE DE ESCENARIO Y GENERACION DE OBJ?
		} else {
			game.removeVisual(self)
		}
	}
}


object lastScreen inherits Screen {
	override method image() = '3.jpg'
	
	method endGame() {
		game.clear() 
		game.addVisual(self)
		game.stop()
	}	
}

