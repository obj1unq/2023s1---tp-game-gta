import wollok.game.*
import crash.*
import escenario.*
import obstaculos.*
import cajas.*
import vidas1.*
import timer.*
import efectos.*


object myScreen {
	
	method configInicial() {
		//tablero
		game.title("Crash")
		game.height(15)
		game.width(21)
		
		game.addVisual(startScreen)
		self.reproducirMusica()
		
		//personajes y acciones
		
		keyboard.s().onPressDo{
			self.iniciarJuego()
		}
	}
	
	method iniciarJuego() {
			game.clear()
			self.addMainScreen()
			crash.correr()
			self.addEscenarioMovil()
			self.agregarComandos()
			game.onTick(1000, "CONTAR_TIEMPO", {timer.contarSegundo()})
	}
	
	method addMainScreen(){
			game.addVisual(mainScreen)
			game.addVisual(crash)
			game.addVisual(messagePoint)
			game.addVisual(displayVidaCounter)
			game.addVisual(timer)
			game.addVisual(lifeBar)
			game.errorReporter(messagePoint)
	}
	
	method reproducirMusica() {
		const backgroundMusic = game.sound("crash_bandicoot_loading.mp3")
		backgroundMusic.shouldLoop(true)
		game.schedule(100, { backgroundMusic.play()} )
		backgroundMusic.volume(0.1)
	}
		
	method agregarComandos(){
		keyboard.space().onPressDo{crash.saltar()}
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
		game.removeTickEvent("GENERAR_NUBES")
		game.removeTickEvent("GENERAR_CAJAS")
		game.removeTickEvent("GENERAR_ELEMENTOS")
		game.removeTickEvent("AVANZAR_ESCENARIO")
	}
	
	method gameOver(){
		drNeoCortex.vanagloriarse()
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
	override method image() = 'screen-start.png'		
}

object mainScreen inherits Screen{
	override method image() = '1.jpg'	
}

object lastScreen inherits Screen {
	override method image() = 'screen-final.png'
	
	method endGame() {
		game.clear() 
		game.addVisual(self)
		timer.addTiempoFinal()
	}	
}


