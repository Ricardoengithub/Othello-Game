/**
 * Proyecto base para el juego de Othello/Reversi
 * @author Rodrigo Colín
 */

Tablero tablero;

/**
 * Método para establecer tamaño de ventana al incluir variables
 */
void settings() {
  tablero =  new Tablero();
  size(tablero.dimension * tablero.tamCasilla, tablero.dimension * tablero.tamCasilla);
}

/**
 * Inicializaciones
 */
void setup() {
  println("Proyecto base para el juego de mesa Othello");
}

/**
 * Ciclo de dibujado
 */
void draw() {
  tablero.display();
  tablero.movimientosPosibles();
}

/**
 * Evento para detectar cuando el usuario da clic
 */
void mousePressed() {
  println("\nClic en la casilla " + "[" + mouseX/tablero.tamCasilla + ", " + mouseY/tablero.tamCasilla + "]");
  if (!tablero.estaOcupado(mouseX/tablero.tamCasilla, mouseY/tablero.tamCasilla) && 
          tablero.movimientoPermitido(mouseX/tablero.tamCasilla, mouseY/tablero.tamCasilla)) {
    tablero.setFicha(mouseX/tablero.tamCasilla, mouseY/tablero.tamCasilla);
    tablero.actualiza(mouseX/tablero.tamCasilla, mouseY/tablero.tamCasilla);
    tablero.cambiarTurno();
    println("[Turno #" + tablero.numeroDeTurno + "] "  + (tablero.turno ? "jugó ficha blanca" : "jugó ficha negra") +
         " (Score: " + int(tablero.cantidadFichas().x) + " - " + int(tablero.cantidadFichas().y) + ")");
  }
}