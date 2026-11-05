class Tarea{
    var property epoca = epocaDeLluvia
    var property tipoJornada = normal
    method esfuerzo()
    method desgaste(tiempo) 
    method recursosProducidos(tiempo) = 50 * (tiempo - self.desgaste(tiempo)) * self.esfuerzo()
    method horasExtra(tiempo){
      return if(tiempo > tipoJornada.tiempo()){
        tiempo - tipoJornada.tiempo()
      }else{
        0
      }
    }
}

class Siembra inherits Tarea{
const property esfuerzo  
override method desgaste(tiempo) = tipoJornada.desgaste(tiempo) + self.horasExtra(tiempo) 

}

object normal{
  method desgaste(tiempo) = 1
  method tiempo() = 8

}

object bajoElSol{
    method desgaste(tiempo) = 1
    method tiempo() = 6
}

class SiembraEnElValle inherits Siembra{
    override method recursosProducidos(tiempo){
     return if(epoca.puedeSembrar()){
            super(tiempo)
     }else{
        0
     }
    }
}
object epocaDeLluvia {
  method puedeSembrar(){
    return false
  }
}

object epocaDeSequia {
  method puedeSembrar(){
    return true
  }
}

class SiembraEnTerrazas inherits Siembra{
    override method recursosProducidos(tiempo) = 3 * super(tiempo)
}


class Mensaje inherits Tarea{
    override method esfuerzo() = 1.4
    override method desgaste(tiempo) = tiempo / 4
}

class MensajeImperial inherits Mensaje{
 override method esfuerzo() = 1.8
 override method desgaste(tiempo) = (super(tiempo) - 2).max(1)   
}


class Ayllus{
  const colcas 

  method mejorColca(habitante) {
    colcas.max({colca => colca.cantidadDeRecursos(habitante)})
  }
  
  method colcasSuaves(habitante) {
    colcas.filter({colca => colca.esColcaSuave(habitante)})
  }

  method tareasMasExigentes(habitante) {
    colcas.filter({colca => colca.tareaMasExigente(habitante)})
  }
}

class Colca{
  const tareasDeColca

  method cantidadDeRecursos(habitante) = tareasDeColca.sum({tarea => habitante.recursosQueProduce(tarea)})

  method esColcaSuave(habitante) {
    return tareasDeColca.any({tarea => habitante.recursosQueProduce(tarea) < 200})
  }

  method tareaMasExigente(habitante) {
    return tareasDeColca.find({tarea => habitante.recursosQueProduce(tarea).max()})
  }
}