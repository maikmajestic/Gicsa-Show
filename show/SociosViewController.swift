//
//  SociosViewController.swift
//  show
//
//  Created by Miguel López Seseña on 24/09/16.
//  Copyright © 2016 Gicsa. All rights reserved.
//

import Foundation
import UIKit


class SociosViewController : UIViewController{
    @IBOutlet weak var ll: UILabel!
    @IBOutlet weak var imSocios: UIImageView!
    var iu = ""
    var imSociosa = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        ll.text = iu
        imSocios.image = imSociosa
    }
}

