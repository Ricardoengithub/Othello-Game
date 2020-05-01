import java.util.ArrayList;

class Arbol{
  
  Tablero tablero; 
  ArrayList<Tablero> hijos; //N hijos
  Tablero tableroaux;
  
  Arbol(Tablero tablero){
    this.tablero = tablero;
    this.tableroaux = new Tablero();
    this.hijos = new ArrayList<Tablero>(); // jugadas posibles
  }
  
  ArrayList<Tablero> hijos(){
     ArrayList<int[]> jugadas = this.tablero.obtenJugadas(); //Obtiene las posiciones de donde se puede colocar una ficha
     
     this.hijos.add(this.tablero);
     for(int i = 0; i < jugadas.size(); i++){ //Crea los distintos escenarios.       
        Tablero t = new Tablero(8,60); // Crea un tablero nuevo
        t.turno = false;
                      
        t.setFicha(jugadas.get(i)[0],jugadas.get(i)[1]); //Para ver si ya no modifica al original.
        t.actualiza(jugadas.get(i)[0],jugadas.get(i)[1]); 
                
        this.hijos.add(t);     
     }
     
     return hijos;
  }
  
}
