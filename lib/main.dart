import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      //inicio de atributos y dependencias 
      child: MaterialApp(
         debugShowCheckedModeBanner: false,   //<-- Código para eliminar el banner
        title: 'EL Arcano',
        
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(108, 236, 29, 126)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

//Se  deja, por el hecho de mantener el metodo (getNEX)

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  // ↓ Add this.
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
  var favorites =<WordPair>[];

  //Pao6
  //Se agrego esta linea, para hacer uncional una secuencia

  void toggleFavorte(){
  if(favorites.contains(current)){
    favorites.remove(current);
  }else{
    favorites.add(current);
  }
  notifyListeners();
}






}
// ...

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> { //7.6n Se uso el REFACTO/SatateFullWidget y se anexaron las lineas de ariiba(La sub clase):

  var selectedIndex =0; ///7.5 Se abgrega esto

  @override
  Widget build(BuildContext context) {//7.8<--Se  agrega para poder tener un respues en el favorites
    
    Widget page;
    switch(selectedIndex){
      case 0:
       page=GeneratorPage();
       break;
      case 1:
        page=FavoritePage();    ///8.2 Se anexo esta linea en referencica a la clase.
        break;
      default:
      throw UnimplementedError('no widgen for $selectedIndex');
    }
    // TODO: implement build
//___________________________________________________________________________________________________________________________________________________
// Se creo la clase para enlistar los favoritos mmns
    return LayoutBuilder( //<---Se convirtio en LAYOUT    7.11
      builder: (context, constraints) {//<--Se agrego el contains  7.12
        return Scaffold( //<--Se uso el REFACTOR de Scaffold/Builder 7.10
          
          body:Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  backgroundColor: const Color.fromARGB(214, 148, 6, 105), // Se le agrega un color a el riel izquierdo.
                  extended: constraints.maxWidth>=700, //<- Se modifico por eso, modificacioó de dimenciones de tamaño de pantalla 7.13 
        
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                     label: Text('Mi hogar 🏠',
                      style: TextStyle( color: Colors.white),
                     ),
                     ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text(
                        'Lo Mío 😶‍🌫️',
                         style: TextStyle( color: Colors.white),  //Recuerda que se divide el codigo y el estylo en la seccion del texto separado por ,
                        ),
                     
                    ),
                  ],
        
                  //Recaciona al NAvigationRail
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
        
                    setState((){
                      selectedIndex=value;
                    }); 
                  }
        
                ),  
              ),
        
              Expanded(
                child: Container(
                  //Edite esto, pora poder editar el fondo.
                  color: Theme.of(context).colorScheme.primaryContainer,
                  //child: GeneratorPage(),///7.9<---Se elimina por el bien de la trama
                  child: page, //<--Se agrega en sucecion de la eliminada en la líne de arriba
      
                  
                  ),
                ),
              

            ]
          ),
        );
      }
    );
  }
}
//_______________________________________________________________________________________________________________________________

class GeneratorPage extends StatelessWidget{ //Creamos un riel nuevo, solo editamos la secuencia de claes(solo esta linea)
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;          
           // ← Add this.
    IconData icon ;
    if(appState.favorites.contains(pair)) {
      icon=Icons.favorite;
    }else{
      icon = Icons.favorite_border;
    }


    return Center(
     // body: Center(    <------7//Se elimino para que exista El riel, por el bien de la trama ps

        child: Column( //<----Se unso el REFACTOR y se uso el apartado WITH CENTER
          mainAxisAlignment: MainAxisAlignment.center, // Se añadio esto para que este centotrado pero pegado al ateral izquierdo.
          children: [
            //Text('A random AWESOME idea:'), SE elimino esta parte por el bien de la trama.
           
            BigCard(pair: pair),                // <--Se quito uno de los Tex, tocando la varible Tex de abajo y usando el(Refactor') y escribiendo BigCard← Change to this. Se
            Row(
              mainAxisSize: MainAxisSize.min, //66.4 dio error pero funciono
              children:[
                //6.7 se agrego el boton deoues de haver hecho la dependencia y la clase.
                ElevatedButton.icon(
                  onPressed: (){
                    appState.toggleFavorte();
                  },
                  //icon: Icon(icon),
                  label: Text('Tú Favorito 🤩'),
                   style: ElevatedButton.styleFrom(
                   backgroundColor: const Color.fromARGB(255, 243, 31, 179), //Sabroso color de Rosa Hombre
                   foregroundColor: Colors.white, //Letra color con valores.
                   elevation: 10,  //Profunidad de sombra
                   shape: RoundedRectangleBorder( // contorno explicito de esquinas y contorno  en el boton.
                    borderRadius: BorderRadius.circular(1), //Capacidad de radio del borede en esquinas
                    side: BorderSide(  //Pemite generada un contorno
                    color: Colors.black, //color del contoeno.
                   width: 2, //grosor del contorno.
                    ),
                   ),
                   ),
                ),

                SizedBox(width:16),

                ElevatedButton( //<--6.3 se agreggo la linea ROW[linesa arriba]^ y children usando REFACTOR/ROW.
                  onPressed: () {
                    appState.getNext();
                  },
                  style: ElevatedButton.styleFrom(
                    
                   backgroundColor: const Color.fromARGB(255, 233, 35, 51), //Sabroso color de Rosa Hombre
                   foregroundColor: Colors.white, //Letra color con valores.
                   elevation: 10,  //Profunidad de sombra
                   shape: RoundedRectangleBorder( // contorno explicito de esquinas y contorno  en el boton.
                    borderRadius: BorderRadius.circular(1), //Capacidad de radio del borede en esquinas
                    side: BorderSide(  //Pemite generada un contorno
                    color: Colors.black, //color del contoeno.
                   width: 2, //grosor del contorno.
                    ),
                   ),
                  ),
                  child: Text('¡Nex!😒'),
                )
              ],
            ),
          ],
        ),
     // ),<---------Perteneciente al sabroso cuerpo anterior.
    );
  }
}
//________________________________________________________________________________________________________________________

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme =Theme.of(context);
    final style= theme.textTheme.displayMedium!.copyWith(
      color: const Color.fromARGB(255, 241, 241, 240)
    );

    return Card(  ///El texto  TEXT anterior se uso rel REFACTOR y se uso el PADDING, depies se quito el padding y se usao el WidGegt
        color: const Color.fromARGB(110, 153, 7, 63),
        child: Padding(
        padding: const EdgeInsets.all(25),
        
        child: Text(
          //Se le añadio 3 lineas que hacen que el el limite de la seccion del sms se mantenga de un solo tamaño.
          pair.asLowerCase,                
          style:style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}


//8.1------Se agrego la clae que permite almacenar y mostrar los favoritos XD


class FavoritePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var appState=context.watch<MyAppState>();
    if(appState.favorites.isEmpty){
      return Center(
        child: Text('No tienes nada 😒',
        style: TextStyle(fontSize: 30, color: Colors.black),
       
        
        ),
      );
    }

    return ListView(
      children: [
        Padding(
          padding:const EdgeInsets.all(25),
          child: Text('Tú tines '
          '${appState.favorites.length} favorito/s, chiquistriquis 😉:',
          style: TextStyle(fontSize:20 ),
          ),
        ),

          for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      
      ],

    );
        
  }




}

// ...