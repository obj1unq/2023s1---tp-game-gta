// ----- Visuales Movimiento de Crash (corriendo / saltando)



object reposo {
	method image() = "crash-1.png" 

	method proximo() {
		return pasoDerecho
	}
}

object pasoDerecho {
	method image() = "crash-2.png"
	
	method proximo() {
		return pasoIzquierdo
	}
}

object pasoIzquierdo {
	method image() = "crash-3.png"
	
	method proximo() {
		return reposo
	}
}

object saltando {
	method image() = "crash-salto-1.png"
	method proximo() {
		return reposo
	}
}

object muerte {
	method image() = "crash-muerte.png"
	method proximo() = self
}
