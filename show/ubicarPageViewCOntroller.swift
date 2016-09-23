//
//  ubicarPageViewCOntroller.swift
//  show
//
//  Created by Jose Chavez on 31/07/16.
//  Copyright © 2016 Jose Chavez. All rights reserved.
//

import UIKit

class ubicarPageViewCOntroller: UIPageViewController {
var map = ""
        
        override func viewDidLoad() {
            super.viewDidLoad()
            print("UBICACION:")
            print(map)
            dataSource = self
            
            if let firstViewController = orderedViewControllers.first {
                setViewControllers([firstViewController],
                                   direction: .Forward,
                                   animated: true,
                                   completion: nil
                                   )
            }
            
          
            
            
        }
        
        
        private(set) lazy var orderedViewControllers: [UIViewController] = {
            return [self.newMapViewController("map")
            ]
        }()
        
        private func newMapViewController(map: String) -> UIViewController {
            return UIStoryboard(name: "Main", bundle: nil) .
                instantiateViewControllerWithIdentifier("\(map)ViewController")
        }
        
        
        
        
    }
    
    // MARK: UIPageViewControllerDataSource
    
    extension ubicarPageViewCOntroller: UIPageViewControllerDataSource {
        
        func pageViewController(pageViewController: UIPageViewController,
                                viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
                return nil
            }
            
            let previousIndex = viewControllerIndex - 1
            
            guard previousIndex >= 0 else {
                return nil
            }
            
            guard orderedViewControllers.count > previousIndex else {
                return nil
            }
            
            return orderedViewControllers[previousIndex]
        }
        
        func pageViewController(pageViewController: UIPageViewController,
                                viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
                return nil
            }
            
            let nextIndex = viewControllerIndex + 1
            let orderedViewControllersCount = orderedViewControllers.count
            
            guard orderedViewControllersCount != nextIndex else {
                return nil
            }
            
            guard orderedViewControllersCount > nextIndex else {
                return nil
            }
            
            return orderedViewControllers[nextIndex]
        }
        
        func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
            return orderedViewControllers.count
        }
        
        func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
            guard let firstViewController = viewControllers?.first,
                firstViewControllerIndex = orderedViewControllers.indexOf(firstViewController) else {
                    return 0
            }
            
            return firstViewControllerIndex
        }
        
        
        
        
}


