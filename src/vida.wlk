import crash.*

object vida {
	
	method sumarA(personaje, cantidad) {
		personaje.vidas().add(cantidad)
	}
	
	method restarA(personaje, cantidad) {
		personaje.vidas().remove(cantidad)
	}
	
}
