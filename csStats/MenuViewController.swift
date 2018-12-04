//
//  ViewController.swift
//  csStats
//
//  Created by Tobias Frantsen on 28/09/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//
import RxSwift
import UIKit

class MenuViewController: UIViewController {
 
    
    @IBOutlet weak var topButtonConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         let orientation = UIDevice.current.orientation
        
        if (orientation == .landscapeLeft || orientation == .landscapeRight) {
            self.topButtonConstraint.constant = 80
            self.view.layoutIfNeeded()
        }
      
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
   
        switch toInterfaceOrientation {
        case .unknown:
            break
        case .portrait, .portraitUpsideDown:
            self.topButtonConstraint.constant = 150
        case .landscapeLeft, .landscapeRight:
            self.topButtonConstraint.constant = 80
        
        }
        
        self.view.layoutIfNeeded()
    }
    
 
}

