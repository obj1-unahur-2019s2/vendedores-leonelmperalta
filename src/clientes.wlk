class Cliente {
	method puedeSerAtendido(vendedor)
}

class ClieneInseguro inherits Cliente{
	override method puedeSerAtendido(vendedor){
		return vendedor.esVersatil() and vendedor.esFirme()
	}
}

class ClienteDetallista inherits Cliente{
	override method puedeSerAtendido(vendedor){
		return vendedor.certificacionesSobreProductos().size() >= 3
	}
}

class ClienteHumanista inherits Cliente{
	override method puedeSerAtendido(vendedor){
		return vendedor.esPersonaFisica()
	}
}


