/**
 * Proyecto base para el juego de Othello/Reversi
 * @author Ricardo Ruiz
 * @author Eduardo Lechuga
 * @author Rodrigo Colín
 */

//Tablero tablero;
Arbol arbol;
Minimax minimax;

Tablero tablero;
int state = 0; //Inicializacion para el selector de estados ente menu y juego
int dificultad = 0; //Inicializacion de la dificultad
Button botonDificil, botonMedia, botonFacil, botonSalir;  // Declaracion de los botones


/**
 * Método para establecer tamaño de ventana al incluir variables
 */
void settings() {
  tablero =  new Tablero();
  int tam = tablero.dimension * tablero.tamCasilla;
  size(tam,tam);
}

/**
 * Inicializaciones
 */
void setup() {
  println("Proyecto base para el juego de mesa Othello");
  //Definicion de los botones para seleccionar la dificultad 
  botonDificil = new Button("Dificil", 180, 50, 100, 50);
  botonMedia = new Button("Media", 180,150,100,50);
  botonFacil = new Button("Facil", 180,250,100,50);
  botonSalir = new Button("Salir", 120, 310, 240, 100);
}

/**
 * Ciclo de dibujado
 */
void draw() {
  //Switch para saber si estamos en el menu o en el juego
  switch(state){
    case(0):
      runMenu();
      break;
    case(1):
      runGame();
      break;
    case(2):
      runGame();
      finalizarJuego();
      break;
  }
}

/**
 * Evento para detectar cuando el usuario da clic
 */
void mousePressed() {
  // Switch para saber que accion debe tomar mousePressed segun donde estemos si en el menu o en el juego
  switch(state){
    case 0:
      seleccionaDificultad();
      break;
    case 1:
      jugar();
      break;
    case 2:
      terminarSesion();
      break;
  }
}


/**
 * Metodo que inicia el menu principal
 */
void runMenu(){
  background(238, 208, 157);
  textoDificultad();
  dibujaBotones();
  resaltaBotones();
  
}

/*
 * Metodo que inicia el juego
 */
void runGame(){
  if(!tablero.juegoTerminado()){
    tablero.display();
    tablero.movimientosPosibles();
  }else{
    state = 2;
  }
}

/*
 * Metodo que manda a dibujar el texto de dificultad
 */
void textoDificultad(){
  PFont f = createFont("Arial",16,true); //Define la fuente 
  textFont(f,20.0);
  text("Selecciona la dificultad", 240,350);
}

/**
 * Metodo que manda a dibujar los botones 
 */
void dibujaBotones(){
  botonDificil.Draw();
  botonMedia.Draw();
  botonFacil.Draw();
}

/*
 * Metodo que manda a dibujar el contorno
 */
void resaltaBotones(){
  botonDificil.resaltar();
  botonMedia.resaltar();
  botonFacil.resaltar();
}

/**
 * Metodo que segun el boton que es presionado selecciona la dificultad
 */
void seleccionaDificultad(){
  if (botonDificil.MouseIsOver()) {
      dificultad = 3;
      state = 1;
    }
  
  if (botonMedia.MouseIsOver()) {
      dificultad = 2;
      state = 1;
    }
    
  if (botonFacil.MouseIsOver()) {
      dificultad = 1;
      state = 1;
    }
}

/*
 * Metodo que ejecuta las condiciones de mousepressed para jugar
 */
void jugar(){
  println("\nClic en la casilla " + "[" + mouseX/tablero.tamCasilla + ", " + mouseY/tablero.tamCasilla + "]");
  if (!tablero.estaOcupado(mouseX/tablero.tamCasilla, mouseY/tablero.tamCasilla) && 
  tablero.movimientoPermitido(mouseX/tablero.tamCasilla, mouseY/tablero.tamCasilla)) {
    tablero.setFicha(mouseX/tablero.tamCasilla, mouseY/tablero.tamCasilla);
    tablero.actualiza(mouseX/tablero.tamCasilla, mouseY/tablero.tamCasilla);
    tablero.cambiarTurno();
    println("[Turno #" + tablero.numeroDeTurno + "] "  + (tablero.turno ? "jugó ficha blanca" : "jugó ficha negra") +
    " (Score: " + int(tablero.cantidadFichas().x) + " - " + int(tablero.cantidadFichas().y) + ")");
    if(tablero.turno == false){
      arbol = new Arbol(tablero);
      minimax = new Minimax(arbol);
      int[] mejorjugada = minimax.mejorJugada();
      tablero.setFicha(mejorjugada[0],mejorjugada[1]);
      tablero.actualiza(mejorjugada[0],mejorjugada[1]);
      println("\nClic en la casilla " + "[" + mejorjugada[0] + ", " + mejorjugada[1] + "]");
      println("[Turno #" + tablero.numeroDeTurno + "] "  + (tablero.turno ? "jugó ficha blanca" : "jugó ficha negra") +
      " (Score: " + int(tablero.cantidadFichas().x) + " - " + int(tablero.cantidadFichas().y) + ")");
      tablero.cambiarTurno(); 
    }
  }
}

/*
 * Metodo que manda a dibuajr el score al finalizar la partida 
 */
void finalizarJuego(){
  int ganador = this.tablero.ganador(); //Guarda al ganador
  String text = "";
  String marcador = "";
  int negras = (int)this.tablero.cantidadFichas().x;
  int blancas = (int)this.tablero.cantidadFichas().y;
  
  //Difumina la pantalla
  fill(255,2);
  noStroke();
  rect(0, 0, 800, 600);
  
  //Presenta el marcador
  marcador = "N " + negras + " : " + "B " + blancas;
  textSize(32); 
  fill(0, 0, 0, 51);
  text(marcador, 240, 180); 
  
  //Esta parte elige el texto ganador 
  switch(ganador){
    case 1:
      text = "Negras Ganan!";
      break;
    case 2:
      text = "Blancas Ganan!";
      break;
    case 0:
      text = "Empate!";
      break;
  }
  textSize(32); 
  fill(0, 0, 0, 51);
  text(text, 240, 240); 
  
  //Presenta el boton para salir
  botonSalir.Draw();
  botonSalir.resaltar();
}

void terminarSesion(){
   if(this.botonSalir.MouseIsOver()) {
      this.botonSalir.salir();
  }
}

/**
 * Metodo para manejar los botones del juego
 */
class Button {
  String nombre;
  float x;    // Posicion x
  float y;    // posicion y
  float w;    // anchura del boton
  float h;    // altura del boton
  PFont f = createFont("Arial",16,true); //Define la fuente 
  
  Button(String nombre, float xpos, float ypos, float widthB, float heightB) {
    this.nombre = nombre;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
  }
  
  void Draw() {
    fill(255);
    stroke(141);
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    fill(0);
    text(nombre, x + (w / 2), y + (h / 2));
  }
  
  void resaltar(){
    if(this.MouseIsOver()){
      fill(520);
      stroke(20);
      rect(x, y, w, h, 10);
      fill(0);
      stroke(0);
    }
  }
  
  void salir(){
    exit();
  }
  
   boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
}
