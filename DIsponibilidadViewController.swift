//
//  DIsponibilidadViewController.swift
//  show
//
//  Created by Jose Chavez on 01/08/16.
//  Copyright © 2016 Jose Chavez. All rights reserved.
//

import UIKit

class DIsponibilidadViewController: UIViewController, UIPageViewControllerDataSource {
    
    // MARK: - Variables
    private var pageViewController: UIPageViewController?
    
    // Initialize it right away here
   // private let contentPDF = ["example","example"]
    
    
    
    var contentPdfs = [String]()
    var contentTitulos = [String]()
    var contentOrden = [Int]()
    
    
    var url = ""

    @IBOutlet weak var webviewDisponibilidad: UIWebView!
    @IBOutlet weak var lblInfo: UILabel!
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        
        // in this case, it's good to combine hidesBarsOnTap with hidesBarsWhenKeyboardAppears
        // so the user can get back to the navigation bar to save
        navigationController?.hidesBarsOnTap = false
        
        navigationController?.hidesBarsWhenKeyboardAppears = false
        navigationController?.navigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        webviewDisponibilidad.hidden=true
        lblInfo.hidden=true
        lblInfo.text = ""
        
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
           
            webviewDisponibilidad.hidden=false
            UIWebView.loadRequest(webviewDisponibilidad)(NSURLRequest(URL: NSURL(string: url)!))
            
            //print (url)
            
            lblInfo.hidden=false
            lblInfo.text=url

        } else {
            print("Internet connection FAILED")
           let alert = UIAlertView(title: "Sin conexión a Internet", message: "Por favor conectese a un punto de acceso. Se mostrarán PDFs", delegate: nil, cancelButtonTitle: "OK")
            webviewDisponibilidad.hidden=true
                
            
            
            alert.show()
            createPageViewController()
            setupPageControl()
        }
               
        // Do any additional setup after loading the view.
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self
        
        if contentPdfs.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        
        if itemController.itemIndex+1 < contentPdfs.count {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    private func getItemController(itemIndex: Int) -> PageItemController? {
        
        if itemIndex < contentPdfs.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as! PageItemController
            pageItemController.itemIndex = itemIndex
            pageItemController.contenido = contentPdfs[itemIndex]
            pageItemController.titulosPDF = contentTitulos[itemIndex]
            pageItemController.disponibilidad = true
            return pageItemController
        }
        
        return nil
    }
    
    // MARK: - Page Indicator
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return contentPdfs.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    // MARK: - Additions
    
    func currentControllerIndex() -> Int {
        
        let pageItemController = self.currentController()
        
        if let controller = pageItemController as? PageItemController {
            return controller.itemIndex
        }
        
        return -1
    }
    
    func currentController() -> UIViewController? {
        
        if self.pageViewController?.viewControllers?.count > 0 {
            return self.pageViewController?.viewControllers![0]
        }
        
        return nil
    }
    
}





