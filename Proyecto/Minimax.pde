class Minimax{

  Arbol arbol;
  
  int[][] pesos = { {4,3,3,4,4,3,3,4},
                    {3,1,3,2,2,3,1,3}, 
                    {3,3,4,3,3,4,3,3}, 
                    {4,2,3,1,1,3,2,4}, 
                    {4,2,3,1,1,3,2,4}, 
                    {3,3,4,3,3,4,3,3},
                    {3,1,3,2,2,3,1,3}, 
                    {4,3,3,3,3,3,3,4}}; 
  
  Minimax(Arbol arbol){
    this.arbol = arbol;
  }
  
  
   ArrayList<Integer> Ganancias(){ //Regresa las ganancias que puede obtener un arbol en especifico.
    ArrayList<Tablero> jugadas = arbol.hijos();
    ArrayList<Integer> ganancias = new ArrayList<Integer>();
    
    ArrayList<int[]> values = jugadas.get(0).obtenJugadas();
    for(int i = 0; i < jugadas.size(); i++){  
        
        if(i >= 1){
          int ganancia = int(jugadas.get(i).cantidadFichas().y) - int(jugadas.get(0).cantidadFichas().y);
          int minimax = ganancia;
          //int minimax = ganancia*pesos[values.get(i-1)[0]][values.get(i-1)[1]];
          ganancias.add(minimax);
        }
        
        
      
    }
    return ganancias;                
  }
  
  
  int[] mejorJugada(){ //Selecciona la mejor jugada de los escenarios posibles.
    ArrayList<Tablero> jugadas = arbol.hijos();
    ArrayList<Integer> ganancias = new ArrayList<Integer>();
    
    ArrayList<int[]> values = jugadas.get(0).obtenJugadas();
    for(int i = 0; i < jugadas.size(); i++){  
        
        if(i >= 1){
          int ganancia = int(jugadas.get(i).cantidadFichas().y) - int(jugadas.get(0).cantidadFichas().y);
          int minimax = ganancia;
          ganancias.add(minimax);
        }
        
        
      
    }
    
    ArrayList<Integer> gananciashijos = new ArrayList<Integer>();
    
    for(int i = 1; i < jugadas.size(); i++){
      Arbol a = new Arbol(jugadas.get(i));
      minimax = new Minimax(a);
      gananciashijos.add(obtenMaximo(minimax.Ganancias())); 
      
    
    }
    
    System.out.println(ganancias.size());
    System.out.println(gananciashijos.size());
    ArrayList<Integer> maxmin = new ArrayList<Integer>();
    for(int i = 0; i < ganancias.size(); i++){
      maxmin.add(ganancias.get(i) - gananciashijos.get(i));
    }
    
    
    
    int indexJugada = 0;
    int min = maxmin.get(0);
    for(int i = 0; i < maxmin.size(); i++){
      if(maxmin.get(i) < min){
        min = maxmin.get(i);
        indexJugada = i;
      }
    }
    
    return values.get(indexJugada);               
  }
  
  
   int[] mejorJugada2(){ //Selecciona la mejor jugada de los escenarios posibles.
    ArrayList<Tablero> jugadas = arbol.hijos();
    ArrayList<Integer> ganancias = new ArrayList<Integer>();
    
    ArrayList<int[]> values = jugadas.get(0).obtenJugadas();
    for(int i = 0; i < jugadas.size(); i++){  
        
        if(i >= 1){
          int ganancia = int(jugadas.get(i).cantidadFichas().y) - int(jugadas.get(0).cantidadFichas().y);
          int minimax = ganancia;
          ganancias.add(minimax);
        }
        
        
      
    }
    
    ArrayList<Integer> gananciashijos = new ArrayList<Integer>();
    
    for(int i = 1; i < jugadas.size(); i++){
      Arbol a = new Arbol(jugadas.get(i));
      minimax = new Minimax(a);
      gananciashijos.add(obtenMaximo(minimax.Ganancias())); 
      
    
    }
    
    System.out.println(ganancias.size());
    System.out.println(gananciashijos.size());
    ArrayList<Integer> maxmin = new ArrayList<Integer>();
    for(int i = 0; i < ganancias.size(); i++){
      maxmin.add(ganancias.get(i) - gananciashijos.get(i));
    }
    
    
    
    int indexJugada = 0;
    int max = 0;
    for(int i = 0; i < maxmin.size(); i++){
      if(maxmin.get(i) > max){
        max = maxmin.get(i);
        indexJugada = i;
      }
    }
    
    return values.get(indexJugada); 
                   
  }
  
  
  int obtenMaximo(ArrayList<Integer> ganancias){
    int max = ganancias.get(0);
    for(int i = 0; i < ganancias.size(); i++){
      if(ganancias.get(i) < max){
        max = ganancias.get(i);
      }
    }
    
    return max;
  }
  
  
  
}
