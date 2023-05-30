import crash.*


object vidaManager {
	const personajes = #{crash}
	
	method encontrarPersonaje(personaje) {
		return personajes.find({pers => pers.equals(personaje)})
	}
	 
	 method fortalecer(personaje, cantidad) {
	 	self.encontrarPersonaje(personaje).sumarVida(cantidad)
	 }
	 
	 method debilitar(personaje, cantidad) {
	 	self.encontrarPersonaje(personaje).restarVida(cantidad)
	 }
}
