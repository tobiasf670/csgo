//
//  MatchViewController.swift
//  csStats
//
//  Created by Tobias Frantsen on 27/11/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//
import RxSwift
import UIKit

class MatchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var matchArray = [MatchModel]()
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
       

        self.collectionView.register(UINib.init(nibName: "MatchViewCell", bundle: nil), forCellWithReuseIdentifier: "MatchViewCell")
        
        SteamAPI.shared.getMatchs().observeOn(MainScheduler.instance)
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        .subscribe(
            onNext: { [weak self] matchArray in
                // Store value
                self?.matchArray = matchArray
                self?.collectionView.reloadData()
            },
            onError: { [weak self] error in
                // Present error
            }
            )
            .disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.matchArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let matchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchViewCell", for: indexPath) as? MatchViewCell {
            
            let time =  self.matchArray[indexPath.row].time ?? ""
            let teamOneImageId = self.matchArray[indexPath.row].teamOneImage ?? ""
            let teamTwoImageId = self.matchArray[indexPath.row].teamTwoImage ?? ""
            let teamOneName = self.matchArray[indexPath.row].teamOneName ?? ""
            let teamTwoName = self.matchArray[indexPath.row].teamTwoName ?? ""
            let BO = self.matchArray[indexPath.row].BO ?? ""
         
            matchCell.setup(time: time, teamOneImage: teamOneImageId, teamTwoImage: teamTwoImageId, teamOneName: teamOneName, teamTwoName: teamTwoName, BO: BO)
          
        
            cell = matchCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: 145)
    }

}
