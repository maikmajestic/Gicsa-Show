//
//  DetailViewController.swift
//  show
//
//  Created by Jose Chavez on 29/07/16.
//  Copyright © 2016 Jose Chavez. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView! //LOGO
    @IBOutlet weak var label: UILabel! //ETIQUETA ESQUINA
    @IBOutlet weak var textView: UITextView! //DESCRIPCION
    @IBOutlet weak var imageViewFondo: UIImageView! //FONDO TRANSPARENTE
    
    //MENU BOTONES
    @IBOutlet weak var btnUbicar: UIButton!;@IBOutlet weak var lblUbicar: UILabel!
    @IBOutlet weak var btnSocios: UIButton!
    @IBOutlet weak var btnGaleria: UIButton!;@IBOutlet weak var lblGaleria: UILabel!
    @IBOutlet weak var btnDisponibilidad: UIButton!;@IBOutlet weak var lblDisponibilidad: UILabel!
    @IBOutlet weak var btnRecorrido: UIButton!;@IBOutlet weak var lblRecorrido: UILabel!
    @IBOutlet weak var btnVideo: UIButton!;@IBOutlet weak var lblVideo: UILabel!
    @IBOutlet weak var btnAvance: UIButton!;@IBOutlet weak var lblAvance: UILabel!
    
    //BARRA INFORMACION
    @IBOutlet weak var lblSocios: UILabel!
    @IBOutlet weak var btSocios: UIButton!
    @IBOutlet weak var imgArea: UIImageView!
    @IBOutlet weak var lblArea: UILabel!
    @IBOutlet weak var imgApertura: UIImageView!
    @IBOutlet weak var lblApertura: UILabel!
    @IBOutlet weak var imgEstacionamiento: UIImageView!
    @IBOutlet weak var lblEstacionamiento: UILabel!
    @IBOutlet weak var imgPuertas: UIImageView!
    @IBOutlet weak var lblPuertas: UILabel!
    
    var idProyecto = ""
    var idShow = ""
    var operacion = ""
    var nombre = ""
    var image = UIImage()
    var fondo = UIImage()
    var texto = ""
    var mapa = ""
    var coordenada = ""
    var url = ""
    var pdf = ""
    var avanceVideo = ""
    var recorridoVideo = ""
    var video = ""
    var avanceVideoUrl = ""
    var recorridoVideoUrl = ""
    var presentacionVideoUrl = ""
    var socios = UIImage()
    var ss = UIImage()
    var socioc = ""
    
    var videoURL: NSURL!
    var area = ""
    var estacionamiento = 0
    var apertura = ""
    var puerta = 0
    
    //GALERIA
    
    var imgGaleria = [String]()
    var imgRuta = [String]()
    
    var pdfRuta = [String]()
    var pdfTitulo = [String]()
    var pdfOrden = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(DetailViewController.handleSwipes(_:)))
        rightSwipe.direction = .Right
        view.addGestureRecognizer(rightSwipe)
        
        self.navigationController?.navigationBar.hidden = false
        // Do any additional setup after loading the view.
        
        
        
        
        print(idProyecto)
        extract_json_data_imagen(Int(idProyecto)!)
        //print(imgGaleria)
        //print(imgRuta)
        extract_json_data_pdf(Int(idShow)!)
        // print(video)
        // print(pdfTitulo)
        // print(pdfRuta)
        
        
        //CARGA LOGO;DESCRIPCION; LABEL; FONDO
       // self.imageView.image = self.image
       // self.label.text = self.title
       // self.textView.text = self.texto
        self.textView.hidden = true
        self.label.hidden = true
        imageViewFondo.image = self.fondo
        
        //OCULTAR BOTONES Y ETIQUETAS BARRA
        btnUbicar.hidden=true;lblUbicar.hidden=true
        btnGaleria.hidden=true;lblGaleria.hidden=true
        btnDisponibilidad.hidden=true;lblDisponibilidad.hidden=true
        btnRecorrido.hidden=true;lblRecorrido.hidden=true
        btnVideo.hidden=true;lblVideo.hidden=true
        btSocios.hidden=true;lblSocios.hidden=true
        btnAvance.hidden=true;lblAvance.hidden=true
        
        //OCULTAR INFORMACION LABEL
        imgArea.hidden=true;lblArea.hidden=true
        imgPuertas.hidden=true;lblPuertas.hidden=true
        imgApertura.hidden=true;lblApertura.hidden=true
        imgEstacionamiento.hidden=true;lblEstacionamiento.hidden=true
        
        
        //MOSTRAR BOTONES DESARROLLO
        
        if(operacion=="Operacion"){
            btnUbicar.hidden=false;lblUbicar.hidden=false
            btnGaleria.hidden=false;lblGaleria.hidden=false
            btnDisponibilidad.hidden=false;lblDisponibilidad.hidden=false
        }else if(operacion=="Desarrollo"){
            btnUbicar.hidden=false;lblUbicar.hidden=false
            btnGaleria.hidden=false;lblGaleria.hidden=false
            btnDisponibilidad.hidden=false;lblDisponibilidad.hidden=false
            btnRecorrido.hidden=false;lblRecorrido.hidden=false
            btnVideo.hidden=true;lblVideo.hidden=true
            btSocios.hidden=false;lblSocios.hidden=false
            btnAvance.hidden=false;lblAvance.hidden=false
            if(avanceVideoUrl == "" && avanceVideo == ""){
                btnAvance.hidden = true
                lblAvance.hidden = true
            }
            if(recorridoVideoUrl == "" && recorridoVideo == ""){
                btnRecorrido.hidden = true
                lblRecorrido.hidden = true
            }
            if(presentacionVideoUrl == "" && video == ""){
                btnVideo.hidden = true
                lblVideo.hidden = true
            }
            if(idProyecto != "77" || idProyecto != "74" || idProyecto != "79" || idProyecto != "68" || idProyecto != "114" || idProyecto != "91" || idProyecto != "78" || idProyecto != "81" || idProyecto != "117"){
                btSocios.hidden = true
                lblSocios.hidden = true
            }
            if(imgGaleria.count == 0){
                btnGaleria.hidden = true
                lblGaleria.hidden = true
            }
            if(pdfRuta.count == 0 ){
                btnDisponibilidad.hidden = true
                lblDisponibilidad.hidden = true
            }
           
        }
        //MOSTRAR INFORMACION
        
        if(area != ""){
            imgArea.hidden=false
            lblArea.hidden=false
            lblArea.text = "AREA RENTABLE \n" + area
        }
        if(apertura != ""){
            imgApertura.hidden=false
            lblApertura.hidden=false
            lblApertura.text = "APERTURA \n" + apertura
        }
        if(estacionamiento != 0){
            imgEstacionamiento.hidden=false
            lblEstacionamiento.hidden=false
            lblEstacionamiento.text = "ESTACIONAMIENTO \n" + String(estacionamiento)
        }
        if(puerta != 0){
            imgPuertas.hidden=false
            lblPuertas.hidden=false
            lblPuertas.text = "PUERTAS \n" + String(puerta)
        }
      
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ubicacion"{
          
            let vc = segue.destinationViewController as! mapViewController
            vc.map = mapa
            vc.coordenadas = coordenada
            vc.nombre = nombre
        }
        
        if segue.identifier == "disponibilidad"{
            
            let vc = segue.destinationViewController as! DIsponibilidadViewController
            vc.url = url
            
            vc.contentPdfs = pdfRuta
            vc.contentOrden = pdfOrden
            vc.contentTitulos = pdfTitulo
            
        }
        
        if segue.identifier == "avance" {
            
            // get destination view controller
            
                let vc = segue.destinationViewController as! AVPlayerViewController
                
                
                self.videoURL = NSBundle.mainBundle().URLForResource(avanceVideo, withExtension: "mp4")!
                vc.player = AVPlayer(URL: self.videoURL)
            
          
            
        }
        
        if segue.identifier == "recorrido" {
            
            // get destination view controller
            let vc = segue.destinationViewController as! AVPlayerViewController
            
            
            self.videoURL = NSBundle.mainBundle().URLForResource(recorridoVideo, withExtension: "mp4")!
            vc.player = AVPlayer(URL: self.videoURL)
            
        }
        
        if segue.identifier == "sociosc" {
            
            // get destination view controller
            let vc = segue.destinationViewController as! SociosViewController
            vc.iu = "jijij"
            vc.imSociosa = socios
            
        }
        
        if segue.identifier == "video" {
            
            // get destination view controller
            let vc = segue.destinationViewController as! AVPlayerViewController
            
            
            self.videoURL = NSBundle.mainBundle().URLForResource(video, withExtension: "mp4")!
            vc.player = AVPlayer(URL: self.videoURL)
            
        }
        
        if segue.identifier == "galeria" {
            
            // get destination view controller
            let vc = segue.destinationViewController as! GaleriaViewController
            
            vc.contentImages = imgGaleria
            
        }
        
    }
    
  
    func extract_json_data_imagen(idProyecto: Int)
    {
        let urlProyectosBundle = NSBundle.mainBundle().URLForResource("imagen", withExtension: "json")
        let dataImagenes = NSData(contentsOfURL: urlProyectosBundle!)
        
       
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(dataImagenes!, options: NSJSONReadingOptions.MutableContainers)
                
                let elementos = jsonResult.count
               // print(elementos)
                
                for anItem in jsonResult as! [Dictionary<String, AnyObject>] {
                    guard
                        
                        //let id_imagen = anItem["id_imagen"] as? Int! ?? 0,
                        let id_proyecto = anItem["id_proyecto"] as? Int! ?? 0,
                        let nombre = anItem["nombre"] as? String! ?? "",
                        let deleted = anItem["deleted"] as? Bool! ?? true,
                        let ruta = anItem["ruta"] as? String! ?? ""
                    else { break }
                    
                    if (id_proyecto == idProyecto && deleted == false && imgGaleria.count < 10){
                        imgGaleria.append(nombre)
                        imgRuta.append(ruta)
                    }
                }
                print (imgGaleria)
               
            } catch let error as NSError {
                print(error)
        }
    }
    
    func extract_json_data_pdf(idShow: Int)
    {
        let urlProyectosBundle = NSBundle.mainBundle().URLForResource("disponibilidad", withExtension: "json")
        let dataPdf = NSData(contentsOfURL: urlProyectosBundle!)
        
        
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(dataPdf!, options: NSJSONReadingOptions.MutableContainers)
            
            //let elementos = jsonResult.count
            //print(elementos)
            
            for anItem in jsonResult as! [Dictionary<String, AnyObject>] {
                
                var rutaF = ""
                guard
                   
                    let id_show = anItem["orderShow"] as? Int! ?? 0,
                    let nombre = anItem["nivel"] as? String! ?? "",
                    let deleted = anItem["deleted"] as? Bool! ?? true,
                    let ruta = anItem["url_impresion"] as? String! ?? "",
                    let orden = anItem["orden_mostrar"] as? Int! ?? 0
                    else { break }
                
                if(ruta != "" && ruta != "NULL"){
                    
                    rutaF = ruta[ruta.startIndex.advancedBy(0)...ruta.endIndex.advancedBy(-5)]
                    rutaF = "PDFS/" + rutaF
                   
                }
                
                if (id_show == idShow && deleted == false){
                    pdfTitulo.append(nombre)
                    pdfRuta.append(rutaF)
                    pdfOrden.append(orden)
                }
                
                
                
            }
         
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if(sender.direction == .Right){
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);        }
        
    }

    @IBAction func pressBtnhome(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
