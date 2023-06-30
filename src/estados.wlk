import wollok.game.*
// ----- Visuales Movimiento de Crash

class Estado {
	method image()
	method position() = game.at(1, 2)
}

object reposo inherits Estado {
	override method image() = "crash-1.png" 
	method proximo() = pasoDerecho
}

object pasoDerecho inherits Estado {
	override method image() = "crash-2.png"
	method proximo() = pasoIzquierdo
}

object pasoIzquierdo inherits Estado {
	override method image() = "crash-3.png"
	method proximo() = reposo
}

object saltando inherits Estado {
	override method image() = "crash-salto-1.png"
	override method position() = game.at(1, 5)
	method proximo() = reposo
}

object muerte inherits Estado {
	override method image() = "crash-muerte.png"
}