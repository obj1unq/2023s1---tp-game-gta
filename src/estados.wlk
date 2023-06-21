// ----- Visuales Movimiento de Crash (corriendo / saltando)



object reposo {
	const property image = "crash-1.png" // mejor asi o con un method?

	method proximo() {
		return pasoDerecho
	}
}

object pasoDerecho {
	const property image = "crash-2.png"
	
	method proximo() {
		return pasoIzquierdo
	}
}

object pasoIzquierdo {
	const property image = "crash-3.png"
	
	method proximo() {
		return reposo
	}
}

object saltando {
	const property image = "crash-salto-1.png"
	method proximo() {
		return reposo
	}
}


