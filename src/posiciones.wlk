import wollok.game.*

object positionRandomizer {
	const ultimaY = game.height()-1
	const ultimaX= game.width()-1
	const anchoTotal = game.width()/2..ultimaX
	
	method nube(){
		const alturas = [6,8,11]
		return game.at(ultimaX, alturas.anyOne())
	}
	
	method bonus(){
		return game.at(anchoTotal.anyOne(), ultimaY)
	}
}

object positionFija {
	const nivelDelPiso = 0
	const sobreElPiso = 2
	const ultimaX= game.width()-1
	
	method nivelDelPiso(){
		return game.at(ultimaX, nivelDelPiso)
	}
	
	method sobreElPiso(){
		return game.at(ultimaX, sobreElPiso)
	}
}

