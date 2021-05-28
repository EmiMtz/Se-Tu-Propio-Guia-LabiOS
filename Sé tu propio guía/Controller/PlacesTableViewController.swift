//
//  PlacesTableViewController.swift
//  Sé tu propio guía
//
//  Created by Tania Rossainz on 8/9/19.
//  Copyright © 2019 Emiliano Martínez. All rights reserved.
//

import UIKit
import CoreLocation

class PlacesTableViewController: UITableViewController {
    
    let locationManager = CLLocationManager ()
    var places: [Place] = [
        Place(name: "Palacio de Bellas Artes", type: "Museo de Arte", location: "Avenido Juárez, Esquina eje central, centro histórico, 06010 Ciudad de México, DF México", image: "PalaBellasArtes", phone: "01 528 647 6500", description: "El Palacio de Bellas Artes constituye todo un símbolo de la cultura y el arte mexicano, con una increíble arquitectura que mezcla a la perfección dos estilos diferentes de manera elegante y en total armonía: el Art Decó y el Art. Noveau. Erigido en base a un diseño del arquitecto Adamo Boeri, su construcción se inició en el año 1904 con la finalidad de albergar un teatro para conmemorar los 100 años de la Independencia del país, se pensaba sería uno de los mayores del mundo, casi a la altura de la Ópera de París. El Palacio de Bellas Artes es la sede de dos museos: el Museo del Palacio de Bellas Artes y el Museo Nacional de Arquitectura.", realidad: "art.scnassets/Palacio/Palacio.scn", isVisited: false),
        Place(name: "Centro Histórico CDMX", type: "Histórico", location: "Calle Plaza de la Constitución, Centro-Área 1, 06060 Cuauhtémoc, CDMX México", image: "zocalo", phone: "S/N", description: "El Centro Histórico de la Ciudad de México alberga los más preciados tesoros culturales del país. Comenzando el recorrido por la Alameda Central podrás ver la arquitectura Ecléctica Porfiriana, y sitios como el famoso “Café Tacuba“, donde podrás deleitarte con los platos típicos del país. Más adelante te encontrarás: El Museo Nacional de Arte, ubicado frente a la Plaza Tolsá, donde también podrás visitar el Palacio de Minería. Otro de los edificios emblemáticos es el Palacio de Correos, de estilo veneciano", realidad: "art.scnassets/Centro/Centro.dae", isVisited: false),
        Place(name: "Monumento El Ángel de la Independencia", type: "Monumento", location: "Calle Florencia 10, Juárez 06600 Cuauhtémoc, CDMX México", image: "angelind", phone: "S/N", description: "Con la finalidad de homenajear a los héroes de la independencia, el Monumento a la Independencia, conocido popularmente también como El Ángel de la Independencia, la Columna de la Independencia o simplemente El Ángel, fue edificado por disposición de Porfirio Díaz en el año 1902, encontrándose la obra en manos del arquitecto Antonio Rivas Mercado. Localizado en el centro de la Plaza de la Constitución, en la Ciudad de México, fue en base a otros importantes monumentos como la columna de Trajano de Roma y la de Alejandro en San Petesburgo. Descansado sobre un zócalo de forma circular, cada uno de los vértices del mismo representa la ley, la justicia, la paz y la guerra y resguarda en su interior los restos de importantes líderes de la Revolución como por ejemplo Miguel Hidalgo.", realidad: "art.scnassets/Palacio/Palacio.scn", isVisited: false),
        Place(name: "Castillo de Chapultepec", type: "Castillo", location: "Primera Sección del Bosque de Chapultepec s/n, 11850 Miguel Hidalgo, CDMX México", image: "castillo", phone: "+52 (55) 5211 5066", description: "Chapultepec ha sido otrora el lugar de descanso de los emperadores aztecas y un testigo mudo de la historia de la ciudad, albergando por aquel entonces algunos santuarios. Aún hoy podrás observar, no sin dificultad, una caverna oculta en el cerro de Chapultepec, considerada por los aztecas como una de las dos puertas de acceso al inframundo. En la cumbre del cerro se erigió en el siglo XVIII una enorme residencia convertida posteriormente en Colegio Militar. Posteriormente fijó allí su residencia el emperador Maximiliano de Habsburgo, quien no hizo más que mejorar el sitio y embellecerlo, comunicando el castillo con el Centro Histórico mediante lo que actualmente es el Paseo de la Reforma. El Castillo de Chapultepec ha sido destinado a diversos fines, como por ejemplo, residencia de varios Presidentes del país, pero finalmente fue donado al Estado en 1940 y convertido en el Museo Nacional de Historia.", realidad: "art.scnassets/Chapul/Chapul.dae", isVisited: false),
        Place(name: "Biblioteca Central UNAM", type: "Escolar", location: "Avenida Insurgentes S, Ciudad Universitaria, 04510 Coyoacán, CDMX México", image: "Bibliounam", phone: "+53 (55) 5622 1616", description: "El 5 de abril de 1956 se inauguró la Biblioteca Central de la Universidad Nacional Autónoma de México (UNAM). Sus cuatro fachadas conforman un solo mosaico considerado como uno de los más grandes del mundo, ya que mide cuatro mil metros cuadrados. Su autor, el pintor y arquitecto Juan O’Gorman, tituló el mural como -Representación Histórica de la Cultura- y para elaborarlo utilizó piedras de colores y vidrio triturado. Orgullosamente, en 2007 la UNESCO declaró esta obra artística como Patrimonio Cultural de la Humanidad, junto con el campus central de Ciudad Universitaria. En el muro norte se puede observar el pasado prehispánico; en el sur, el pasado colonial; en el muro oriente, el mundo contemporáneo, y en el poniente, la Universidad y el México actual.",  realidad: "art.scnassets/Biblioteca/Biblioteca.dae", isVisited: false),
        Place(name: "Estadio Olímpico Universitario", type: "Deportes", location: "Avenida de los Insurgentes Sur, s/n, 04511 Coyoacán, CDMX México", image: "estadio", phone: "+52 (55) 5616 5274", description: "Se trata del Estadio de la Universidad Nacional Autónoma de México, cuya edificación fue hecha para los Juegos Olímpicos de 1968. Cuenta con una pista tartán, vestidores, diversos accesos y su construcción está basada en piedra volcánica. Cabe destacar que es el segundo estadio más grande de México, con una capacidad para albergar a 68 mil 954 espectadores. Este recinto también es el escenario para los juegos del equipo de futbol americano de la Universidad.", realidad: "art.scnassets/Olimpico/Olimpico.dae", isVisited: false),
        Place(name: "Monumental Plaza de Toros México", type: "Deportes", location: "Augusto Rodín 130, Ciudad de los Deportes, 03710 Benito Juárez, CDMX México", image: "plazatoros", phone: "+52 (55) 7591 5557", description: "La Plaza de Toros México es resultado del proyecto del empresario yucateco Neguib Simón Jalife, quien a fines de los años veinte, radicado ya en la ciudad de México, advirtió que a la capital le hacía falta un foro a su altura para actividades recreativas. Fue así que en 1939 adquirió gran parte de los terrenos pertenecientes al antiguo rancho de San Carlos, cercanos a lo que fue la hacienda de San José –entre las actuales colonias Noche Buena, Ciudad de los Deportes y San José Insurgentes–, donde planeó construir una ciudad de los deportes, que incluiría una gran plaza de toros.", realidad: "art.scnassets/plaza/plaza.dae", isVisited: false),
        Place(name: "Museo Frida Kahlo", type: "Museo", location: "Calle Londres 247, Del Carmen, 04100 Coyoacán, CDMX México", image: "casdiego", phone: "+52 (55) 5554 5999", description: "En 1931, por encargo de Diego Rivera, Juan O'Gorman diseñó una de las primeras estructuras arquitectónicas funcionalistas en Latinoamérica. Este espacio sería una casa-estudio para Diego y otra para Frida, cuya construcción termina en 1932.  El matrimonio no habitaría el espacio sino hasta 1934, año en que vuelven a México después de una estancia de tres años en Estados Unidos.", realidad: "art.scnassets/Palacio/Palacio.scn", isVisited: false),
        Place(name: "Plaza La Conchita", type: "Parques", location: "Calle Plaza de la Conchita 7-15, Barrio La Concepción, 04020 Coyoacán, CDMX México", image: "concha", phone: "+52 (55) 5554 0560", description: "Cuando Hernán Cortés llegó a Coyoacán, en 1521, mandó construir el templo sobre lo que era un centro ceremonial prehispánico. Fue aquí donde se celebró la primera misa de la región, por lo que se considera que la Conchita es una de las iglesias más antiguas de la ciudad. La orden religiosa asignada a Coyoacán en 1524 fue la de los franciscanos. La leyenda cuenta que, en realidad, fue un regalo de Cortes a La Malinche, que también vivió en ese barrio y fue una de sus asiduas feligresas, ya como católica conversa que asistía a misa todos los días.", realidad: "art.scnassets/Palacio/Palacio.scn", isVisited: false),
        Place(name: "Monumento a la Revolución", type: "Monumento", location: "Calle de la República 35, Tabacalera, 06030 Cuauhtémoc, CDMX México", image: "revolucion", phone: "S/N", description: "Fue parte del proyecto arquitectónico de Porfirio Díaz, para la construcción del Palacio legislativo con motivo del centenario de la Independencia de México, se pensaba sería uno de los más grandes y lujosos del mundo; obra, que irónicamente terminaría por conmemorar de alguna manera su derrocamiento. En 1912 la obra suspendió labores por falta de recursos como consecuencia del movimiento revolucionario, dos décadas después, Émile Bénard quiso rescatar su proyecto y presentó al gobierno de Álvaro Obregón la propuesta de adaptación de la estructura a un panteón para los héroes de la guerra. Sin embargo, este intento quedó frustrado con las muertes de Obregón y Bénard. Entre 1942 y 1970 se trasladaron a este lugar los restos de Francisco I. Madero, Venustiano Carranza, Francisco Villa, Plutarco Elías Calles y Lázaro Cárdenas.", realidad: "art.scnassets/Palacio/Palacio.scn", isVisited: false),
        Place(name: "El Eco", type: "Museo", location: "Calle James Sullivan 43, San Rafael, 06470 Cuauhtémoc, CDMX México", image: "eco", phone: "+52 (55) 5535 5186", description: "Inspirado en diferentes conceptos del expresionismo alemán, Mathias Goeritz, arquitecto y diseñador, vino a la Ciudad de México en 1949 a trabajar en diferentes proyectos que implicaban arquitectura y arte. Con geometrías irregulares y un espacio de resonancia para los artistas de su época, Goeritz deja apreciar estos elementos en el Museo “El Eco”, un espacio diferente a las galerías convencionales, donde los artistas llegan a producir su proyecto. El simple hecho de observar la construcción de este museo, nos explica buena parte de la arquitectura moderna mexicana. También puedes apreciar dos de las esculturas de Goeritz en Ciudad Universitaria: “Corona de Pedregal” y “Tú y yo”.", realidad: "art.scnassets/Palacio/Palacio.scn", isVisited: false),
        Place(name: "Museo de Cera", type: "Museo", location: "Calle Londres 6, Juárez, 06600 Cuauhtémoc, CDMX México", image: "cera", phone: "+53 (55) 5546 3784", description: "La Antigua Hacienda de la Teja fue construida en la primera década del siglo XX, por el arquitecto Antonio Rivas Mercado, el mismo que hizo el Ángel de la Independencia y otras maravillas de la capital. Este genio, la diseñó con un estilo afrancesado muy singular, para imitar las casas que en aquella época estaban en Avenida Juárez. Atravesó muchas facetas. Unos años fue un inmueble abandonado que visitaban los niños para espantarse. Luego se transformó en un hermoso restaurante, más tarde en las oficinas del INBA y finalmente, antes de que el gobierno la demoliera, se convirtió en la sede del Museo de Cera de la Ciudad de México.", realidad: "art.scnassets/Palacio/Palacio.scn", isVisited: false),
        Place(name: "Los Pinos", type: "Residencia Oficial", location: "Calle Parque Lira, Bosque de Chapultepec 1 Sección, 11850 Ciudad de México, CDMX México", image: "pinos", phone: "+52 (55) 5093 5300", description: "Los Pinos, la casa que habian habitado los presidentes desde Lázaro Cárdenas, estableciendo así una tradición. Un 30 de noviembre de hace 85 años, justo el día en que tomó protesta Lázaro Cárdenas, ‘El Tata’ anunció que no viviría en el Castillo de Chapultepec. Con esta decisión, nos dejó un museo que a la fecha recibe miles de visitantes y mudó la residencia oficial del Presidente a Los Pinos.", realidad: "art.scnassets/Palacio/Palacio.scn", isVisited: false),
        Place(name: "Zona Arqueológica de Cuicuilco", type: "Sitio Arqueológico", location: "Avenida Insurgentes S 146, Parque del Pedregal, Tlalpan, CDMX México", image: "cuicuilco", phone: "S/N", description: "Cuicuilco fue uno de los primeros y más importantes centros ceremoniales en el Valle de México, que desapareció con la erupción del volcán Xitle. La evidencia arqueológica indica que Cuicuilco se desarrolló como asentamiento desde el primer milenio antes de Cristo, durante el Preclásico, como un pequeño asentamiento, sus habitantes interactuaban con otros sitios tanto de la Cuenca de México como de regiones relativamente distantes, por ejemplo Chupícuaro al oeste y Monte Albán al sureste.", realidad: "art.scnassets/Palacio/Palacio.scn", isVisited: false),
        Place(name: "Teotihuacán", type: "Sitio Arqueológico", location: "Circuito Pirámides, San Francisco Mazapa, 55820 Teotihuacán, Edomex México", image: "teoti", phone: "+52 (594) 956 0276", description: "Los pobladores de la cultura teotihuacana construyeron basamentos piramidales de gran tamaño que se distinguían porque usaban el talud y el tablero. Sus construcciones más importantes fueron las pirámides del Sol y de la Luna, así como la Calzada de los Muertos y el Templo de Quetzalcóatl. También edificaron plataformas en las que se llevaron a cabo ceremonias religiosas y celebraciones populares. El valle de Teotihuacán, situado entre los de México y Puebla, en pleno corazón del Altiplano mexicano, fue el lugar donde surgió la primera gran ciudad de América. Un diminuto poblado durante el Formativo, experimentó un acelerado proceso de crecimiento que le llevó a alcanzar los 22,5 km’ de superficie y una población cercana a los 150.000 habitantes. A finales del periodo Clásico, la ciudad fue saqueada, quemada y destruida. Se desconocen con exactitud las causas de la decadencia de esta cultura, pero algunos investigadores consideran que sucumbió por la sobreexplotación de los recursos naturales, las invasiones de otros pueblos y los conflictos internos.",  realidad: "art.scnassets/Piramide/Piramide.dae", isVisited: false),
        Place(name: "Plaza de las Tres Culturas", type: "Plazas públicas", location: "Plaza de las tres Culturas, Nonoalco Tlatelolco, 06900 Cuauhtémoc, CDMX Ciudad de México", image: "tresculturas", phone: "S/N", description: "El nombre de la Plaza de las Tres Culturas, recordada como el lugar donde ocurrió la masacre del movimiento estudiantil de 1968, uno de los sucesos más sangrientos del siglo XX en México, proviene de la convergencia de elementos arquitectónicos pertenecientes a tres etapas históricas diferentes. El 2 de octubre de 1968, dos años después del fin de la construcción del conjunto Nonoalco – Tlatelolco , diseñado por el arquitecto Mario Pani, cientos de estudiantes y simpatizantes del movimiento estudiantil que buscaba el fin de la represión gubernamental se encontraron rodeados por militares y policías, que dispararon sin piedad contra los manifestantes.", realidad: "art.scnassets/Palacio/Palacio.scn", isVisited: false),

    ]
    
    // MARK:- View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLocation()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Customize the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Rubik-Medium", size: 40.0) {
            // For Xcode 9 users, NSAttributedString.Key is equal to NSAttributedStringKey
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 255.0/255.0, green: 165.0/255.0, blue: 0.0/255.0, alpha: 1), NSAttributedString.Key.font: customFont]
        }
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    func initLocation() {
        let permiso = CLLocationManager.authorizationStatus()
        
        if permiso == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
        } else if permiso == .denied {
            alertLocation(tit: "Error de localización", men: "Actualmente tiene denegada la localización del dispositivo")
        } else if permiso == .restricted{
             alertLocation(tit: "Error de localización", men: "Actualmente tiene restringida la localización del dispositivo")
        } else {
            guard (locationManager.location?.coordinate) != nil else { return }
        }
    }
    
    func alertLocation(tit: String, men: String)  {
        let alerta = UIAlertController(title: tit, message: men,preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alerta.addAction(action)
        self.present(alerta, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- UITableViewDataSource Protocol
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PlacesTableViewCell
        
        // Configure the cell...
        cell.nameLabel.text = places[indexPath.row].name
        cell.locationLabel.text = places[indexPath.row].location
        cell.typeLabel.text = places[indexPath.row].type
        cell.thumbnailImageView.image = UIImage(named: places[indexPath.row].image)
        
        cell.accessoryType = places[indexPath.row].isVisited ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    // MARK:- UITableViewDelegate Protocol
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            // Delete the row from the data source
            self.places.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Call completion handler to dismiss the action button
            completionHandler(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "Just checking in at " + self.places[indexPath.row].name
            
            let activityController: UIActivityViewController
            
            if let imageToShare = UIImage(named: self.places[indexPath.row].image) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        deleteAction.image = UIImage(named: "delete")
        
        shareAction.backgroundColor = UIColor(red: 254.0/255.0, green: 149.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        shareAction.image = UIImage(named: "share")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let checkInAction = UIContextualAction(style: .normal, title: "Check-in") { (action, sourceView, completionHandler) in
            let cell = tableView.cellForRow(at: indexPath) as! PlacesTableViewCell
            self.places[indexPath.row].isVisited = (self.places[indexPath.row].isVisited) ? false : true
            cell.accessoryType = (self.places[indexPath.row].isVisited) ? .checkmark : .none
            
            completionHandler(true)
        }
        
        // Customize the action button
        checkInAction.backgroundColor = UIColor(red: 39, green: 174, blue: 96)
        
        checkInAction.image = self.places[indexPath.row].isVisited ? UIImage(named: "undo") : UIImage(named: "tick")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkInAction])
        
        return swipeConfiguration
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlaceDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! PlacesDetailViewController
                destinationController.place = places[indexPath.row]
            }
        }
    }
    
    
}

