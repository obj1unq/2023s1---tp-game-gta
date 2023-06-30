import wollok.game.*

object positionRandomizer {
	const alturaMaxima = game.height()-1
	const anchoMaximo= game.width()-1
	const anchoTotal = (game.width()/2)..anchoMaximo
	
	method nube(){
		const alturas = [6,8,11]
		return game.at(anchoMaximo, alturas.anyOne())
	}
	
	method cajas(){
		return game.at(anchoTotal.anyOne(), alturaMaxima)
	}
}

object positionPiso {
	const property alturaDelPiso = 2
	const anchoMaximo= game.width()-1
	
	method nivelDelPiso(){
		return game.at(anchoMaximo, 0)
	}
	
	method sobreElPiso(){
		return game.at(anchoMaximo, alturaDelPiso)
	}
}

