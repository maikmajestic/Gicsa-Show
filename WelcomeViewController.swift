//
//  WelcomeViewController.swift
//  show
//
//  Created by Jose Chavez on 09/08/16.
//  Copyright © 2016 Jose Chavez. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

      override func viewWillAppear(animated: Bool) {
         self.navigationController?.navigationBar.hidden = true
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc = segue.destinationViewController as! ViewController
        vc.tipoInmueble = segue.identifier!
        
    }
    
  

}
