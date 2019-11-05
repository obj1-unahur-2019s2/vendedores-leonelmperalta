class Vendedor {
	var property certificaciones = #{}
	
	method esPersonaFisica()
	method puedeTrabajarEn(ciudad)
	method esInfluyente()
	method esVersatil(){
		return certificaciones.size() >= 3 and certificaciones.any({c=> c.sobreProductos()}) and certificaciones.any({c => not c.sobreProductos()})
	}
	method esFirme(){
		return self.puntajePorCertificaciones() >= 30
	}
	method puntajePorCertificaciones(){
		return certificaciones.sum({c => c.puntajeQueOtorga()})
	}	
	method esGenerico(){
		return certificaciones.any({c => not c.sobreProductos()})
	}
	method recibirCertificacion(certificacion){
		certificaciones.add(certificacion)
	}
	method tieneAfinidad(centroDeDistribucion){
		return self.puedeTrabajarEn(centroDeDistribucion.ciudad())
	}
	method esCandidato(centroDeDistribucion){
		return self.esVersatil() and self.tieneAfinidad(centroDeDistribucion)
	}
	method certificacionesSobreProductos(){
		return certificaciones.filter({c => c.sobreProductos()})
	}
}

class VendedorFijo inherits Vendedor{
	var property ciudadDondeVive
	override method puedeTrabajarEn(ciudad){
		return ciudad == ciudadDondeVive
	}
	override method esInfluyente() = false
	override method esPersonaFisica() = true
}

class VendedorViajante inherits Vendedor{
	var property provinciasHabilitadas = #{}
	override method esPersonaFisica() = true
	method ciudadesHabilitadas(){
		return provinciasHabilitadas.map({p => p.ciudades()})
	}
	override method puedeTrabajarEn(ciudad){
		return self.ciudadesHabilitadas().any({c => c.contains(ciudad)})
	}
	override method esInfluyente(){
		return provinciasHabilitadas.sum({p => p.poblacion()}) >= 10000000
	}
}

class ComercioCorresponsal inherits Vendedor{
	var property ciudadesConSucursal = #{}
	override method esPersonaFisica() = false
	override method puedeTrabajarEn(ciudad){
		return ciudadesConSucursal.contains(ciudad)
	}
	method provinciasConSucursal(){
		return ciudadesConSucursal.map({c => c.Provincia()}).asSet()
	}
	override method esInfluyente(){
		return ciudadesConSucursal.size() >= 5 or self.provinciasConSucursal().size() >= 3 
	}
	override method tieneAfinidad(centroDeDistribucion){
		return super(centroDeDistribucion) and ciudadesConSucursal.any({c => not centroDeDistribucion.puedeCubrir(c)})
	}
}
