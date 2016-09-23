//
//  mapViewController.swift
//  show
//
//  Created by Jose Chavez on 31/07/16.
//  Copyright © 2016 Jose Chavez. All rights reserved.
//

import UIKit
import MapKit

class mapViewController: UIViewController,MKMapViewDelegate {
var map = ""
var nombre = ""
var coordenadas = ""
    @IBOutlet weak var imgMap: UIImageView!
    @IBOutlet weak var mapaVista: MKMapView!
    
    var latitud = Double()
    var longitud = Double()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgMap.hidden=true
        mapaVista.hidden=true
       
        
        
        let rangeOfZero = coordenadas.rangeOfString(",",
                                                options: NSStringCompareOptions.BackwardsSearch)
        let longitudS = String(coordenadas.characters.suffixFrom(rangeOfZero!.endIndex))
        let latitudS = String(coordenadas.characters.prefixUpTo(rangeOfZero!.startIndex))
        
        if let latitudF: Double = (latitudS as NSString).doubleValue{
            latitud = latitudF
        }
        if let longitudF: Double = (longitudS as NSString).doubleValue{
            longitud = longitudF
        }
        print (latitud)
        print (longitud)
        
        
        // Do any additional setup after loading the view.
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitud, longitud)
        
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            mapaVista.hidden=false
            imgMap.hidden=true
            
            let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            
            if CLLocationCoordinate2DIsValid (location) {
                mapaVista.setRegion(region, animated: true)
            }
            
            mapaVista.delegate = self
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = nombre
            annotation.subtitle = ""
            
            mapaVista.addAnnotation(annotation)
            mapaVista.mapType = .Hybrid
            
            
            
        } else {
            print("Internet connection FAILED")
            mapaVista.hidden=true
            imgMap.hidden=false
            imgMap.image=UIImage(named:map)
        }
        
        /*
            mapaVista.hidden=false
            
            let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            
            if CLLocationCoordinate2DIsValid (location) {
                mapaVista.setRegion(region, animated: true)
            }
            
            mapaVista.delegate = self
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = nombre
            annotation.subtitle = ""
            
            mapaVista.addAnnotation(annotation)
            mapaVista.mapType = .Hybrid
            
         */
         
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
