class Persona{
var energia 

method energia() = energia

method resistencia() 

method tiempoDeTrabajo()

method realizarTarea(tarea) {
  if (!self.puedeTrabajar(tarea)){
    self.error("energia insuficiente para trabajar")
  }
    energia = self.energiaPerdida(tarea) 
}

method energiaPerdida(tarea) {
    return energia - ( tarea.recursosProducidos(self.tiempoDeTrabajo()) / self.resistencia() )
}

method puedeTrabajar(tarea) {
  return (energia > tarea.recursosProducidos(self.tiempoDeTrabajo()) /  self.resistencia() )
}

method recursosQueProduce(tarea) {
  return if(self.puedeTrabajar(tarea)){
    tarea.recursosProducidos(self.tiempoDeTrabajo())
  }
  0
}
}

class Campesino inherits Persona{
 const tiempoDeTrabajo   
 override method tiempoDeTrabajo() = tiempoDeTrabajo
 override method resistencia() = 10
}

class Elite inherits Persona{
    override method resistencia() = 12

    override method energiaPerdida(tarea) {
       return super(tarea) + 5
    }

    override method tiempoDeTrabajo() = 10

    override method puedeTrabajar(tarea) {
      return super(tarea) && (tarea.recursosProducidos(self.tiempoDeTrabajo()) > 500)
    }
}