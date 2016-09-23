//
//  ProyectoPageViewController.swift
//  show
//
//  Created by Jose Chavez on 03/08/16.
//  Copyright © 2016 Jose Chavez. All rights reserved.
//

import UIKit

class pageViewController: UIPageViewController {

        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            dataSource = self
            
            if let firstViewController = orderedViewControllers.first {
                setViewControllers([firstViewController],
                                   direction: .Forward,
                                   animated: true,
                                   completion: nil)
            }
            
            
            
        }
        
        
        private(set) lazy var orderedViewControllers: [UIViewController] = {
            return [self.newColoredViewController("desarrolloID"),
                    self.newColoredViewController("operacionID")]
        }()
        
        private func newColoredViewController(proyecto: String) -> UIViewController {
            return UIStoryboard(name: "Main", bundle: nil) .
                instantiateViewControllerWithIdentifier("\(proyecto)ViewController")
        }
        
        
        
        
    }
    
    // MARK: UIPageViewControllerDataSource
    
    extension pageViewController: UIPageViewControllerDataSource {
        
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


