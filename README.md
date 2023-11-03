# movie_avilatek_app

- El estado de la aplicación está desarrollado en flutter_riverpod para un mayor dominio del manejo de la api y el tema de la aplicación.
- sdk: '>=3.1.5 <4.0.0' esta es la versión en la que está elaborada la aplicación, para compilar en la terminar debe correr el siguiente comando: 
flutter pub get
- y debería bajar todas las dependencias del proyecto, la aplicación no solicita permisos ni se le hicieron cambios en archivos de kotlin o swift, asi que deberia compilar en Android como IOS
- 2400x1080 estas son las caracteristicas de mi pantalla en la cual se armó la aplicación en todo momento
La aplicación cuenta con capas y subcapas para la gestion del proyecto y la gestión de carpetas, tomando en cuenta las carpetas de dominio para la administración local del datasource y los repositorios de manera local, creando las entidades para manejar mejor la información trabajando en conjunto con la carpeta de infraestructura la cual se encarga de manejar toda la información pesada que venga de manera externa, en este caso los datasource obteniendo la respuesta json mapeandola a las entidades correspondientes (Movie, MovieDetails, Actor, ActorInfo) y una carpeta de presentación donde se manejan las pantallas, los widgets y por último los providers.

- The application state is developed in flutter_riverpod for better control of API handling and application theming.
- sdk: '>=3.1.5 <4.0.0' is the version in which the application is built. To compile it, you should run the following command in the terminal: 
flutter pub get.
This command will download all the project dependencies. The application does not request any permissions, and no changes were made to Kotlin or Swift files, so it should compile on both Android and iOS.
2400x1080 is the screen resolution on which the application was developed.
- The application has layers and sublayers for the management of the project and the folder management, taking into account the domain folders for the local administration of the datasource and the locals repositories, creating the entities to better handle the information working together with the infrastructure folder which is in charge of handling all the heavy information that comes from an external source, in this case the datasource obtaining the json response mapping it to the corresponding entities (Movie, MovieDetails, Actor, ActorInfo) and a presentation folder where the screens, the widgets and finally the providers are handled.