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
        guard let statsArray = self.stats else {
            return
        }
        for stats in statsArray {
            if stats.name == StatsType.total_kills.rawValue {
                self.label.text = String(stats.value!)
            }
        }
    }


}

