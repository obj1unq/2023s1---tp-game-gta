import wollok.game.*
import crash.*
import escenario.*
import obstaculos.*
import cajas.*
import vidas.*
import timer.*


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
			game.onTick(1000, "CONTAR_TIEMPO", {timer.contarSegundo()})
		}
	}
	
	method addMainScreen(){
			game.addVisual(mainScreen)
			game.addVisual(crash)
			game.addVisual(messagePoint)
			game.addVisual(displayVidaCounter)
			game.addVisual(timer)
			game.addVisual(lifeBar)
			crash.estadoInicial()
			game.errorReporter(displayVidaCounter) //TODO: comentar esto para entrega final.
	}
	
	method agregarComandos(){
		keyboard.space().onPressDo{crash.saltar()}
		
		//keyboard.p().onPressDo{pausedScreen.togglePausedScreen()} TODO: decidir si va a tener pausa o no.
	}
	
	method addEscenarioMovil(){
		//escenario
		game.onTick (4000, "GENERAR_NUBES", {nubeManager.generar()})
		game.onTick (7000, "GENERAR_ELEMENTOS", {obstaculosManager.generar()})
		game.onTick(180, "AVANZAR_ESCENARIO", {escenario.avanzarEscenario()})
		game.onTick(7000, "GENERAR_CAJAS", {cajaManager.generar()})
		game.onCollideDo(crash, {objeto => objeto.chocar(crash)})
	}
	
	method congelarEscenario(){
		//DUDA ESPERA UN INTERVALO PARA SACARLO???
		game.removeTickEvent("GENERAR_NUBES")
		game.removeTickEvent("GENERAR_CAJAS")
		game.removeTickEvent("GENERAR_ELEMENTOS")
		game.removeTickEvent("AVANZAR_ESCENARIO") //ERROR las cajas siguen avanzando
	}
	
	method gameOver(){
		self.congelarEscenario()
		game.schedule(3000, {lastScreen.endGame(); game.schedule(8000, {game.stop()})})
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
			// TODO: DUDA: COMO DETENER AVANCE DE ESCENARIO Y GENERACION DE OBJ? o solo que la vida contador no lo contabilice?
		} else {
			game.removeVisual(self)
		}
	}
}


object lastScreen inherits Screen {
	override method image() = 'the-end.png'
	
	method endGame() {
		game.clear() 
		game.addVisual(self)
		timer.addTiempoFinal()
	}	
}


