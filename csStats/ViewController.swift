//
//  ViewController.swift
//  csStats
//
//  Created by Tobias Frantsen on 28/09/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//
import RxSwift
import UIKit

class ViewController: UIViewController {
 
    @IBOutlet weak var label: UILabel!
    let disposeBag = DisposeBag()
    var stats: [SteamModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        SteamAPI.shared.getStats().subscribe(
            onNext: { [weak self] statsarray in
                // Store value
                self?.stats = statsarray
                self?.showTotalKills()
            },
            onError: { [weak self] error in
                // Present error
            }
            )
            .disposed(by: disposeBag)
        
        
    }
    
    
    func showTotalKills() {
        
        if let foo = self.stats?.first(where: {$0.name == StatsType.total_kills.rawValue }) {
            // do something with foo
            self.label.text = String(foo.value!)
        } else {
            // item could not be found
            self.label.text = "NO VALUE"
        }
    }


}

