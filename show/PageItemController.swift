//
//  PageItemController.swift
//  Paging_Swift
//
//  Created by olxios on 26/10/14.
//  Copyright (c) 2014 swiftiostutorials.com. All rights reserved.
//

import UIKit

class PageItemController: UIViewController {
    
    @IBOutlet var contentImageView: UIImageView?
    
    @IBOutlet weak var lblTitulo: UILabel!
    
    @IBOutlet weak var contentWebView: UIWebView!
    @IBOutlet weak var imgTitulo: UIImageView!
    
    // MARK: - Variables
    
    var galeria: Bool = false
    var disponibilidad: Bool = false
    var itemIndex: Int = 0
    var titulosPDF: String = ""
    
    var contenido: String = "" {
        
        didSet {
            
            if let imageView = contentImageView {
                
                imageView.image = UIImage(named: contenido)
            }
            
        }
    }
    
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contentImageView!.hidden = true
        lblTitulo.hidden = true
        imgTitulo.hidden = true
        contentWebView.hidden = true
        if(galeria == true){
            contentImageView!.image = UIImage(named: contenido)
            contentImageView!.hidden=false
        }
        
        if(disponibilidad == true){
            lblTitulo.hidden = false
            imgTitulo.hidden = false
            lblTitulo.text = titulosPDF
            contentWebView.hidden = false
            
            if let pdf = NSBundle.mainBundle().URLForResource(contenido, withExtension: "pdf", subdirectory: nil, localization: nil) { let req = NSURLRequest(URL: pdf)
                //let webView = UIWebView(frame: CGRectMake(20,20,self.view.frame.size.width-40,self.view.frame.size.height-40))
                
                contentWebView.loadRequest(req)
                contentWebView.scalesPageToFit = true
                                
                self.view.addSubview(contentWebView)
                
            }
            
        }
       
        
        

    }
}
