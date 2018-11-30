//
//  ShowStatsCollectionViewController.swift
//  csStats
//
//  Created by Tobias Frantsen on 02/11/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//
import RxSwift
import UIKit

private let reuseIdentifier = "Cell"

enum cellType {
    case statsChart
    case statsText
    
}

class ShowStatsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var statsArray = StatsType.allCases
    
    let disposeBag = DisposeBag()
    var stats: [SteamModel]?
    var cellRow: [cellType]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        SteamAPI.shared.getStats().subscribe(
            onNext: { [weak self] statsarray in
                // Store value
                self?.stats = statsarray
                self?.collectionView.reloadData()
            },
            onError: { [weak self] error in
                // Present error
            }
            )
            .disposed(by: disposeBag)
        
        

        
        // Register cell classes
        
         self.collectionView.register(UINib.init(nibName: "StatsViewCell", bundle: nil), forCellWithReuseIdentifier: "StatsViewCell")
        self.collectionView.register(UINib.init(nibName: "BarChartViewCell", bundle: nil), forCellWithReuseIdentifier: "BarChartViewCell")

        // Do any additional setup after loading the view.
    }


    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        if let count = self.stats?.count {
//            return count / 3
//        } else {
//            return 0
//        }
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatsViewCell", for: indexPath) as? StatsViewCell else {
//            return UICollectionViewCell()
//        }
        
        if indexPath.row == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BarChartViewCell", for: indexPath) as? BarChartViewCell {
                cell.setup(stats: self.stats)
                return cell
            }
        }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatsViewCell", for: indexPath) as? StatsViewCell {
            let type = self.statsArray[indexPath.row]
            if let element = self.stats?.first(where: {$0.name == type.rawValue}) {
                cell.setupCell(imageName: nil, name: element.name!, value: String(element.value!))
            }
            return cell
        }
       return UICollectionViewCell()
    }

   

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
              if indexPath.row == 0 {
            return CGSize(width: (view.frame.width) - 10, height: 200)
        }
        debugPrint(CGSize(width: (view.frame.width/3) - 10, height: 150))
        return CGSize(width: (view.frame.width/3) - 10, height: 150)
    }
}
