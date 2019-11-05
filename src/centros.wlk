class CentroDeDistribucion {
	var property ciudad
	var property vendedores = []
	
	method agregarVendedor(vendedor){
		if (not vendedores.contains(vendedor)){
			vendedores.add(vendedor)
		}
		else{
			self.error("el vendedor ya esta registrado en el centro")
		}
	}
	method vendedorEstrella(){
		return vendedores.max({v => v.puntajePorCertificaciones()})
	}
	method puedeCubrir(unaCiudad){
		return vendedores.any({v => v.puedeTrabajarEn(unaCiudad)})
	}
	method vendedoresGenericos(){
		return vendedores.filter({v => v.esGenerico()})
	}
	method esRobusto(){
		return vendedores.count({v => v.esFirme()}) >= 3
	}
	method repartirCertificacion(unaCertificacion){
		vendedores.forEach({v => v.recibirCertificacion(unaCertificacion)})
	}
	
	
}
