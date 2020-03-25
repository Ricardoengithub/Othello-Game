/**
 * Definición de un tablero para el juego de Othello
 * @author Rodrigo Colín
 */
class Tablero {
  /**
   * Cantidad de casillas en horizontal y vertical del tablero
   */
  int dimension;

  /**
   * El tamaño en pixeles de cada casilla cuadrada del tablero
   */
  int tamCasilla;

  /**
   * Representación lógica del tablero. El valor númerico representa:
   * 0 = casilla vacia
   * 1 = casilla con ficha del primer jugador
   * 2 = casilla con ficha del segundo jugador
   */
  int[][] mundo;

  /**
   * Representa de quién es el turno bajo la siguiente convención:
   * true = turno del jugador 1 (Negras)
   * false = turno del jugador 2 (Blancas)
   */
  boolean turno;
  
  /**
   * Contador de la cantidad de turnos en el tablero
   */
  int numeroDeTurno;

  /**
   * Constructor base de un tablero. 
   * @param dimension Cantidad de casillas del tablero, comúnmente ocho.
   * @param tamCasilla Tamaño en pixeles de cada casilla
   */
  Tablero(int dimension, int tamCasilla) {
    this.dimension = dimension;
    this.tamCasilla = tamCasilla;
    turno = true;
    numeroDeTurno = 0;
    mundo = new int[dimension][dimension];
    // Configuración inicial (colocar 4 fichas al centro del tablero):
    mundo[(dimension/2)-1][dimension/2] = 1;
    mundo[dimension/2][(dimension/2)-1] = 1;
    mundo[(dimension/2)-1][(dimension/2)-1] = 2;
    mundo[dimension/2][dimension/2] = 2;
  }

  /**
   * Constructor por default de un tablero con las siguientes propiedades:
   * Tablero de 8x8 casillas, cada casilla de un tamaño de 60 pixeles,
   */
  Tablero() {
    this(8, 60);
  }

  /**
   * Dibuja en pantalla el tablero, es decir, dibuja las casillas y las fichas de los jugadores
   */
  void display() {
    color fondo = color(238, 208, 157); // El color de fondo del tablero
    color linea = color(0, 0, 0); // El color de línea del tablero
    int grosor = 2; // Ancho de línea (en pixeles)
    color colorJugador1 = color(0); // Color de ficha para el primer jugador
    color colorJugador2 = color(255); // Color de ficha para el segundo jugador
    
    // Doble iteración para recorrer cada casilla del tablero
    for (int i = 0; i < dimension; i++)
      for (int j = 0; j < dimension; j++) {
        // Dibujar cada casilla del tablero:
        fill(fondo); // establecer color de fondo
        stroke(linea); // establecer color de línea
        strokeWeight(grosor); // establecer ancho de línea
        rect(i*tamCasilla, j*tamCasilla, tamCasilla, tamCasilla); //Dibuja rectangulos

        // Dibujar las fichas de los jugadores:
        if (mundo[i][j] != 0 && (mundo[i][j] == 1 || mundo[i][j] == 2)) { // en caso de que la casilla no esté vacia
          fill(mundo[i][j] == 1 ? colorJugador1 : colorJugador2); // establecer el color de la ficha
          noStroke(); // quitar contorno de línea
          ellipse(i*tamCasilla+(tamCasilla/2), j*tamCasilla+(tamCasilla/2), tamCasilla*3/5, tamCasilla*3/5);
        }
      }
  }

  /**
   * Coloca o establece una ficha en una casilla específica del tablero.
   * Nota: El eje vertical está invertido y el conteo empieza en cero.
   * @param posX Coordenada horizontal de la casilla para establecer la ficha
   * @param posX Coordenada vertical de la casilla para establecer la ficha
   * @param turno Representa el turno o color de ficha a establecer
   */
  void setFicha(int posX, int posY, boolean turno) {
    mundo[posX][posY] = turno ? 1 : 2;
  }
  
  /**
   * Coloca o establece una ficha en una casilla específica del tablero segun el turno del tablero.
   * @param posX Coordenada horizontal de la casilla para establecer la ficha
   * @param posX Coordenada vertical de la casilla para establecer la ficha
   */
  void setFicha(int posX, int posY) {
    this.setFicha(posX, posY, this.turno);
  }

  /**
   * Representa el cambio de turno. Normalmente representa la última acción del turno
   * Recordemos que true es jugador uno y false jugador dos
   */
  void cambiarTurno() {
    turno = !turno;
    numeroDeTurno += 1;
  }

  /**
   * Verifica si en la posición de una casilla dada existe una ficha (sin importar su color)
   * @param posX Coordenada horizontal de la casilla a verificar
   * @param posY Coordenada vertical de la casilla a verificar
   * @return true si hay una ficha de cualquier color en la casilla, false en otro caso
   */
  boolean estaOcupado(int posX, int posY) {
    return mundo[posX][posY] != 0;
  }
  
  /**
   * @param posX Coordenada horizontal de la casilla a verificar
   * @param posY Coordenada vertical de la casilla a verificar
   * @return true si es una movida valida hacia arriba, false en otro caso
   */
  boolean verificaArriba(int posX, int posY){
    try{
      int turnoSiguiente = turno ? 2 : 1; 
      if(mundo[posX][posY-1] == turnoSiguiente ){
        for(int i = 2; i < 8; i++){
          int turnoActual = turno ? 1 : 2;
           if(mundo[posX][posY-i] == 0)
            return false; 
          if(mundo[posX][posY-i] == turnoActual)
            return true; 
        }
        return false;      
      }
      return false;
    }catch(Exception e){
      System.out.println("Arriba");
      return false;
    }
  }

  /**
   * @param posX Coordenada horizontal de la casilla a verificar
   * @param posY Coordenada vertical de la casilla a verificar
   * @return true si es una movida valida hacia abajo, false en otro caso
   */
  boolean verificaAbajo(int posX, int posY){
    try{
      int turnoSiguiente = turno ? 2 : 1; 
      if(mundo[posX][posY+1] == turnoSiguiente ){
        for(int i = 2; i < 8; i++){
          int turnoActual = turno ? 1 : 2; 
          if(mundo[posX][posY+i] == 0)
            return false;           
          if(mundo[posX][posY+i] == turnoActual)
            return true; 
        }
        return false;      
      }
      return false;
    }catch(Exception e){
      System.out.println("Abajo");
      return false;
    }
  }

  /**
   * @param posX Coordenada horizontal de la casilla a verificar
   * @param posY Coordenada vertical de la casilla a verificar
   * @return true si es una movida valida hacia la derecha, false en otro caso
   */
  boolean verificaDerecha(int posX, int posY){
    try{
      int turnoSiguiente = turno ? 2 : 1; 
      if(mundo[posX+1][posY] == turnoSiguiente ){
        for(int i = 2; i < 8; i++){
          int turnoActual = turno ? 1 : 2; 
          if(mundo[posX+i][posY] == 0)
            return false; 
          if(mundo[posX+i][posY] == turnoActual)
            return true; 
        }
        return false;      
      }
      return false;
    }catch(Exception e){
      System.out.println("Derecha");
      return false;
    }
  }
  
    boolean verificaDerechaArriba(int posX, int posY){
    try{
      int turnoSiguiente = turno ? 2 : 1; 
      if(mundo[posX+1][posY-1] == turnoSiguiente ){
        for(int i = 2; i < 8; i++){
          int turnoActual = turno ? 1 : 2; 
          if(mundo[posX+i][posY-i] == 0)
            return false; 
          if(mundo[posX+i][posY-i] == turnoActual)
            return true; 
        }
        return false;      
      }
      return false;
    }catch(Exception e){
      System.out.println("Derecha");
      return false;
    }
  }
  
    boolean verificaDerechaAbajo(int posX, int posY){
    try{
      int turnoSiguiente = turno ? 2 : 1; 
      if(mundo[posX+1][posY+1] == turnoSiguiente ){
        for(int i = 2; i < 8; i++){
          int turnoActual = turno ? 1 : 2; 
          if(mundo[posX+i][posY+i] == 0)
            return false; 
          if(mundo[posX+i][posY+i] == turnoActual)
            return true; 
        }
        return false;      
      }
      return false;
    }catch(Exception e){
      System.out.println("Derecha");
      return false;
    }
  }

  /**
   * @param posX Coordenada horizontal de la casilla a verificar
   * @param posY Coordenada vertical de la casilla a verificar
   * @return true si es una movida valida hacia la izquierda, false en otro caso
   */
  boolean verificaIzquierda(int posX, int posY){
    try{
      int turnoSiguiente = turno ? 2 : 1; 
      if(mundo[posX-1][posY] == turnoSiguiente ){
        for(int i = 2; i < 8; i++){
          int turnoActual = turno ? 1 : 2; 
          if(mundo[posX-i][posY] == 0)
            return false;           
          if(mundo[posX-i][posY] == turnoActual)
            return true; 
        }
        return false;      
      }
      return false;
    }catch(Exception e){
      System.out.println("Izquierda");
      return false;
    }
  }
  
  
    boolean verificaIzquierdaArriba(int posX, int posY){
    try{
      int turnoSiguiente = turno ? 2 : 1; 
      if(mundo[posX-1][posY-1] == turnoSiguiente ){
        for(int i = 2; i < 8; i++){
          int turnoActual = turno ? 1 : 2; 
          if(mundo[posX-i][posY-i] == 0)
            return false;
          if(mundo[posX-i][posY-i] == turnoActual)
            return true; 
        }
        return false;      
      }
      return false;
    }catch(Exception e){
      System.out.println("Izquierda");
      return false;
    }
  }
  
    boolean verificaIzquierdaAbajo(int posX, int posY){
    try{
      int turnoSiguiente = turno ? 2 : 1; 
      if(mundo[posX-1][posY+1] == turnoSiguiente ){
        for(int i = 2; i < 8; i++){
          int turnoActual = turno ? 1 : 2; 
        if(mundo[posX-i][posY+i] == 0)
            return false;       
          if(mundo[posX-i][posY+i] == turnoActual)
            return true; 
        }
        return false;      
      }
      return false;
    }catch(Exception e){
      System.out.println("Izquierda");
      return false;
    }
  }
  /**
   * Metodo que verifica si el movimiento que quiere hacer el usuario esta permitido
   * segun las reglas del juego
   * @param posX Coordenada horizontal de la casilla a verificar
   * @param posY Coordenada vertical de la casilla a verificar
   * @return true si es un movimiento permitido, false en otro caso
   */
  boolean movimientoPermitido(int posX, int posY){
    boolean permitido = (verificaArriba(posX, posY) || verificaAbajo(posX, posY) 
                        || verificaIzquierda(posX, posY) || verificaDerecha(posX, posY)
                        || verificaIzquierdaArriba(posX, posY) || verificaIzquierdaAbajo(posX, posY)
                        || verificaDerechaArriba(posX, posY) || verificaDerechaAbajo(posX, posY)
                        );
    return permitido;
  }

  /**
   * Metodo que indica las casillas donde hay movimientos posibles
   */
  void movimientosPosibles(){
    for(int i = 0; i<dimension; i++){
      for(int j = 0; j<dimension; j++){
        if(movimientoPermitido(i,j) && !estaOcupado(i,j)){
          if(turno){
            stroke(0,0,0);
            strokeWeight(3);
            noFill();
            circle(i*tamCasilla+(tamCasilla/2), j*tamCasilla+(tamCasilla/2), (tamCasilla/2));            
          }else{
            stroke(255,255,255);
            strokeWeight(5);
            noFill();
            circle(i*tamCasilla+(tamCasilla/2), j*tamCasilla+(tamCasilla/2), (tamCasilla/2)); 
          
          }

        }
      }
    }
  }

  /**
   * @param posX Coordenada horizontal de la casilla a verificar
   * @param posY Coordenada vertical de la casilla a verificar
   * Metodo que actualiza las fichas superiores segun las reglas de Othello
   */
  void actualizaArriba(int posX, int posY){
    int aliadas = turno ? 1 : 2;
    try{
      if(verificaArriba(posX, posY)){
        for(int i = 1; i < dimension; i++){
          if(mundo[posX][posY-i] == aliadas){
            break;
          }else{
            mundo[posX][posY-i] = aliadas;

          }
        }
      }
    }catch(Exception e){
      System.out.println("asd");
    }
  }

  /**
   * @param posX Coordenada horizontal de la casilla a verificar
   * @param posY Coordenada vertical de la casilla a verificar
   * Metodo que actualiza las fichas a la izquierda segun las reglas de Othello
   */
  void actualizaAbajo(int posX, int posY){
    int aliadas = turno ? 1 : 2;
    try{
      if(verificaAbajo(posX, posY)){
        for(int i = 1; i < dimension; i++){
          if(mundo[posX][posY+i] == aliadas){
            break;
          }else{
            mundo[posX][posY+i] = aliadas;

          }
        }
      }
    }catch(Exception e){
      System.out.println("asd");
    }
  }

  /**
   * @param posX Coordenada horizontal de la casilla a verificar
   * @param posY Coordenada vertical de la casilla a verificar
   * Metodo que actualiza las fichas a la derecha segun las reglas de Othello
   */
  void actualizaDerecha(int posX, int posY){
    int aliadas = turno ? 1 : 2;
    try{
      if(verificaDerecha(posX, posY)){
        for(int i = 1; i < dimension; i++){
          if(mundo[posX+i][posY] == aliadas){
            break;
          }else{
            mundo[posX+i][posY] = aliadas;

          }
        }
      }
    }catch(Exception e){
      System.out.println("asd");
    }
  }

  /**
   * @param posX Coordenada horizontal de la casilla a verificar
   * @param posY Coordenada vertical de la casilla a verificar
   * Metodo que actualiza las fichas a la izquierda segun las reglas de Othello
   */
  void actualizaIzquierda(int posX, int posY){
    int aliadas = turno ? 1 : 2;
    try{
      if(verificaIzquierda(posX, posY)){
        for(int i = 1; i < dimension; i++){
          if(mundo[posX-i][posY] == aliadas){
            break;
          }else{
            mundo[posX-i][posY] = aliadas;

          }
        }
      }
    }catch(Exception e){
      System.out.println("asd");
    }
  }
  
    void actualizaIzquierdaArriba(int posX, int posY){
    int aliadas = turno ? 1 : 2;
    try{
      if(verificaIzquierdaArriba(posX, posY)){
        for(int i = 1; i < dimension; i++){
          if(mundo[posX-i][posY-i] == aliadas){
            break;
          }else{
            mundo[posX-i][posY-i] = aliadas;

          }
        }
      }
    }catch(Exception e){
      System.out.println("asd");
    }
  }
    void actualizaIzquierdaAbajo(int posX, int posY){
    int aliadas = turno ? 1 : 2;
    try{
      if(verificaIzquierdaAbajo(posX, posY)){
        for(int i = 1; i < dimension; i++){
          if(mundo[posX-i][posY+i] == aliadas){
            break;
          }else{
            mundo[posX-i][posY+i] = aliadas;

          }
        }
      }
    }catch(Exception e){
      System.out.println("asd");
    }
  }
  
  
    void actualizaDerechaArriba(int posX, int posY){
    int aliadas = turno ? 1 : 2;
    try{
      if(verificaDerechaArriba(posX, posY)){
        for(int i = 1; i < dimension; i++){
          if(mundo[posX+i][posY-i] == aliadas){
            break;
          }else{
            mundo[posX+i][posY-i] = aliadas;

          }
        }
      }
    }catch(Exception e){
      System.out.println("asd");
    }
  }
    void actualizaDerechaAbajo(int posX, int posY){
    int aliadas = turno ? 1 : 2;
    try{
      if(verificaDerechaAbajo(posX, posY)){
        for(int i = 1; i < dimension; i++){
          if(mundo[posX+i][posY+i] == aliadas){
            break;
          }else{
            mundo[posX+i][posY+i] = aliadas;

          }
        }
      }
    }catch(Exception e){
      System.out.println("asd");
    }
  }

  void actualiza(int posX, int posY){
      actualizaArriba(posX, posY);
      actualizaAbajo(posX, posY);
      actualizaIzquierda(posX, posY);
      actualizaDerecha(posX,posY);
      actualizaDerechaArriba(posX, posY);
      actualizaDerechaAbajo(posX, posY);
      actualizaIzquierdaArriba(posX, posY);
      actualizaIzquierdaAbajo(posX, posY);
  }

  

  /**
   * Cuenta la cantidad de fichas de un jugador
   * @return La cantidad de fichas de ambos jugadores en el tablero como vector, 
   * donde x = jugador1, y = jugador2
   */
  PVector cantidadFichas() {
    PVector contador = new PVector();
    for (int i = 0; i < dimension; i++)
      for (int j = 0; j < dimension; j++){
        if(mundo[i][j] == 1)
          contador.x += 1;
        if(mundo[i][j] == 2)
          contador.y += 1;
      }
    return contador;
  }
}
