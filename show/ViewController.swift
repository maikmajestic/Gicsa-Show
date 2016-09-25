//
//  ViewController.swift
//  show
//
//  Created by Jose Chavez on 29/07/16.
//  Copyright © 2016 Jose Chavez. All rights reserved.
//

import UIKit


//JSON
let urlUpdate = NSBundle.mainBundle().URLForResource("json_update_resource", withExtension: "json")
//let urlUpdate = NSURL(string: "http://morelosgeek.com/darkaw/show/Data.json")
let dataUpdate = NSData(contentsOfURL: urlUpdate!)

let urlProyectosRemoto = NSURL(string:"http://morelosgeek.com/darkaw/show/proyectos_prueba.json")
let urlProyectosCalidad = NSURL(string:"http://172.16.160.53:300/api/Show/getProyect")
let urlProyectosBundle = NSBundle.mainBundle().URLForResource("proyectos_prueba", withExtension: "json")
let dataProyectos = NSData(contentsOfURL: urlProyectosBundle!)



class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var imgFondo: UIImageView!
   
   
   
    
    
        //DATOS DINAMICOS
   
    
    var tipoInmueble = ""
    
    var idProyectos = [String]()
    var tipoInmuebles = [String]()
    var idShows = [String]()
    var nombres = [String]()
    var descripciones = [String]()
    var logos = [String]()
    var socios = [String]()
    var fondos = [String]()
    var mapas = [String]()
    var coordenadas = [String]()
    var dispobilidadUrls = [String]()
   
    var operaciones = [String]()
    var avanceVideos = [String]()
    var recorridoVideos = [String]()
    var videos = [String]()
    var estacionamientos = [String]()
    var puertas = [Int]()
    var glas = [String]()
    var aperturas = [String]()
    var videosUrls = [String]()
    var videosRecorridoUrls = [String]()
    var videosAvanceUrls = [String]()
    
    var sections: [String] = ["Desarrollo", "Operacion"]
    
   
    //ROWS ARRAY
    var operacionArray: [String] = []
    var desarrolloArray: [String] = []
    
    var titulos = [[String]]()
    
   //  override func viewWillAppear(animated: Bool) {
   //     self.navigationController?.navigationBar.hidden = false
   // }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        rightSwipe.direction = .Right
        view.addGestureRecognizer(rightSwipe)
        
        
      //  let str: String! = self.restorationIdentifier
        
       
       extract_json_data("Desarrollo", tipo: tipoInmueble)
        
      
        
            //extract_json_data("Operacion", tipo: tipoInmueble)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        let defaults = NSUserDefaults.standardUserDefaults()
        let install = defaults.stringForKey("install")
        
        //self.view.backgroundColor = UIColor.yellowColor()
        
        
        
        
        //ACTUALIZACION
        
        if (install == nil ){
            print("install=", install)
            defaults.setObject("1", forKey: "install")
           
            
            
            print("instalando datos...")
            //print("no se necesita actualizacion")
            
        }
        
       // let requiereActualizacion = obtenerActualizacion()
        let requiereActualizacion = false
        
        if(requiereActualizacion == true && install == "1"){
            defaults.setObject("1", forKey: "update")
            print("Actualización requerida")
            
        }else if (requiereActualizacion != true && install == "1"){
            print("No necesita actualizar")
        }
        
    
       
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        //LLENAR COLLECION1
        var index = indexPath.row
        if (indexPath.section == 0){ //SECCION DESARROLLO
            
        }else if (indexPath.section == 1){ //SECCION OPERACION
            index = indexPath.row + desarrolloArray.count
        }
        
        cell.imageview.image = UIImage(named:logos[index])
       // cell.titlelabel?.text = self.titulos[indexPath.section][indexPath.row]
        cell.titlelabel?.text = ""
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("segueOperacion", sender: self)
    }
    
   
    
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "cabecera", forIndexPath: indexPath) as! HeaderView
            headerView.etiqueta.text = sections[indexPath.section]
            headerView.etiqueta.text = ""
            if(sections[indexPath.section] == "Desarrollo"){
                headerView.imagen.image =  UIImage(named: "endesarrollo.png")
            }else if(sections[indexPath.section] == "Operacion"){
                headerView.imagen.image =  UIImage(named: "enoperacion.png")
            }
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return titulos[section].count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
      
        return titulos.count
    }
    
  
    
    
  
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject?) {
        //print(segue.identifier)
       
            if segue.identifier == "segueOperacion"{
                let indexPaths = self.collectionView!.indexPathsForSelectedItems()!
                let indexPath = indexPaths[0] as NSIndexPath
                let vc = segue.destinationViewController as! DetailViewController
                print(indexPath.row)
                print(indexPath.section)
              
                var index = indexPath.row
                if (indexPath.section == 0){ //SECCION DESARROLLO
                    
                }else if (indexPath.section == 1){ //SECCION OPERACION
                    index = indexPath.row + desarrolloArray.count
                }
                
                // vc.image = self.imageArray[indexPath.row]!
                vc.idProyecto = self.idProyectos[index]
                vc.idShow = self.idShows[index]
                vc.title = self.nombres[index]
                //vc.texto = self.descripciones[index]
                vc.image = UIImage(named:logos[index])!
                vc.fondo = UIImage(named:fondos[index])!
                vc.nombre = self.nombres[index]
                vc.mapa = self.mapas[index]
                vc.coordenada = self.coordenadas[index]
                vc.url = self.dispobilidadUrls[index]
                vc.socios = UIImage(named:socios[index])!
                
                vc.operacion = self.operaciones[index]
                vc.avanceVideo = self.avanceVideos[index]
                vc.recorridoVideo = self.recorridoVideos[index]
                vc.video = self.videos[index]
                vc.avanceVideoUrl = self.videosAvanceUrls[index]
                vc.recorridoVideoUrl = self.videosRecorridoUrls[index]
                vc.presentacionVideoUrl = self.videosUrls[index]
                
                vc.apertura = self.aperturas[index]
                vc.estacionamiento = self.estacionamientos[index]
                vc.area = self.glas[index]
                vc.puerta = self.puertas[index]
                
                print("Enviando datos de proyectos")
               
        }
        
        
    }
    
    
    
    
    func extract_json_data(tipoOperacion: String, tipo: String)
    {
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(dataProyectos!, options: .AllowFragments)
            
            guard
                let proyectos = json["proyectos"] as? [[String: AnyObject]]
                else { return }
            
            for proyecto in proyectos {
                
                guard
                    let id_proyecto = proyecto["id_proyecto"] as? Int! ?? 0,
                    let tipoInmueble = proyecto["tipoInmueble"] as? String! ?? "",
                    let id_show = proyecto["orderShow"] as? Int! ?? 0,
                    let nombre = proyecto["nombre"] as? String! ?? "",
                    
                    let gla = proyecto["gla"] as? String! ?? "",
                    let puerta = proyecto["puertas"] as? Int! ?? 0,
                    let cajones_estacionamiento = proyecto ["cajones_estacionamiento"] as? String! ?? "",
                    let apertura = proyecto["apertura"] as? String! ?? "",
                    let fondo = proyecto["fondo"] as? String! ?? "",
                    let socio = proyecto["socios"] as? String! ?? "",
                    
                    let logo = proyecto ["logo"] as? String! ?? "",
                    //let sh_acerca_de = proyecto ["sh_acerca_de"] as? String! ?? "",
                    let mapa = proyecto ["mapa"] as? String! ?? "",
                    let coordenada = proyecto ["coordenadas"] as? String! ?? "",
                    let disponibilidadUrl = proyecto["disponibilidad"] as? String! ?? "",
                    //let disponibilidadPdf = proyecto["pdf"] as? String! ?? "",
                    let operacion = proyecto["operacion"] as? String! ?? "",
                    let avanceVideo = proyecto["avance_video"] as? String! ?? "",
                    let recorridoVideo = proyecto["recorrido_video"] as? String! ?? "",
                    let video = proyecto["video"] as? String! ?? "",
                
                    let video_url = proyecto["video_url"] as? String! ?? "",
                    let recorridoVideo_url = proyecto["recorrido_video_url"] as? String! ?? "",
                    let avanceVideo_url = proyecto["avance_video_url"] as? String! ?? ""
                    
                    else { break }
                
                var avideo = ""
                var rvideo = ""
                var vvideo = ""
                
                var logoF = ""
                var fondoF = ""
                
                if(avanceVideo != "" && avanceVideo != "NULL"){
                     avideo = avanceVideo[avanceVideo.startIndex.advancedBy(0)...avanceVideo.endIndex.advancedBy(-5)]
                }
                if(recorridoVideo != "" && recorridoVideo != "NULL"){
                     rvideo = recorridoVideo[recorridoVideo.startIndex.advancedBy(0)...recorridoVideo.endIndex.advancedBy(-5)]
                }
                if(video != "" && video != "NULL"){
                     vvideo = video[video.startIndex.advancedBy(0)...video.endIndex.advancedBy(-5)]
                }
                              
                if(logo != "" && logo != "NULL"){
                    if(tipoInmueble == "Explanada"){
                        logoF = logo
                    }
                    else{
                        let rangeOfZeroL = logo.rangeOfString("/", options: NSStringCompareOptions.BackwardsSearch)
                        logoF = String(logo.characters.suffixFrom(rangeOfZeroL!.endIndex))
                        logoF = logoF[logoF.startIndex.advancedBy(0)...logoF.endIndex.advancedBy(-5)]
                    }
                }
                
                if(fondo != "" && fondo != "NULL"){
                    if(tipoInmueble == "Explanada"){
                        fondoF = fondo
                    }
                        else{
                    let rangeOfZeroF = fondo.rangeOfString("/", options: NSStringCompareOptions.BackwardsSearch)
                    fondoF = String(fondo.characters.suffixFrom(rangeOfZeroF!.endIndex))
                    fondoF = fondoF[fondoF.startIndex.advancedBy(0)...fondoF.endIndex.advancedBy(-1)]
                    }
                }else{
                    fondoF = "fondo_arcosbosques.jpg"
                }
                if (tipoInmueble == tipo){
                    if(tipoOperacion == operacion){
                        desarrolloArray.append(nombre)
                    }else{
                        operacionArray.append(nombre)
                    }
                    
                    idProyectos.append(String(id_proyecto))
                    idShows.append(String(id_show))
                    nombres.append(nombre)
                   // descripciones.append(sh_acerca_de)
                    logos.append(logoF)
                    fondos.append(fondoF)
                    socios.append(socio)
                    mapas.append(mapa)
                    coordenadas.append(coordenada)
                    dispobilidadUrls.append(disponibilidadUrl)
                   
                    operaciones.append(operacion)
                    avanceVideos.append(avideo)
                    recorridoVideos.append(rvideo)
                    videos.append(vvideo)
                    glas.append(gla)
                    puertas.append(puerta)
                    estacionamientos.append(cajones_estacionamiento)
                    aperturas.append(apertura)
                    videosUrls.append(video_url)
                    videosRecorridoUrls.append(recorridoVideo_url)
                    videosAvanceUrls.append(avanceVideo_url)
                    
                 }
              
            }
            print(desarrolloArray)
            titulos.append(desarrolloArray)
            titulos.append(operacionArray)
            print (nombres)
            
        } catch {
            // Handle Error
        }
        
    }
    
   
    //OBTENER JSON ACTUALIZACION
    
    func obtenerActualizacion() -> Bool{
        
        var update = false
        do {
            let object = try NSJSONSerialization.JSONObjectWithData(dataUpdate!, options: .AllowFragments)
            if let dictionary = object as? [String: AnyObject] {
                update = readJSONObject(dictionary)
            }
        } catch {
            // Handle Error
        }
        
        return update
    }
    
    func readJSONObject(object: [String: AnyObject]) -> Bool{
        let update = object["update"] as? Bool
        return update!
    }
    
    
    
    func assignbackground(tipo:String){
          let fondos_inicio = [
            UIImage(named:"fondo_desarrollo.jpg"),
            UIImage(named:"fondo_operacion.jpg"),
            UIImage(named:"GicsaShow-HomeNaranja.jpg"),
            UIImage(named:"fondo_index1.jpg"),
            UIImage(named:"fondo_index2.jpg"),
            UIImage(named:"fondo_index3.jpg"),
            UIImage(named:"fondo_index4.jpg"),
            UIImage(named:"fondo_index5.jpg")
            ]
        let random = Int(arc4random_uniform(UInt32(fondos_inicio.count)))
        
        if(tipo == "Operacion") {
            imgFondo.image = fondos_inicio[1]
        }else if (tipo == "Desarrollo"){
            imgFondo.image = fondos_inicio[0]
        }
        
        imgFondo.image = fondos_inicio[random]
        
        
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        
    }
   
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if(sender.direction == .Right){
            
           self.navigationController?.popToRootViewControllerAnimated(true)
        }
        
    }
    @IBAction func pressBtnHome(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

}

