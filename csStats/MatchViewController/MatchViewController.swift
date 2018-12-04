//
//  MatchViewController.swift
//  csStats
//
//  Created by Tobias Frantsen on 27/11/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//
import Alamofire
import RxSwift
import RealmSwift
import UIKit


enum iphoneType {
    case iPhone5
    case iPhone6
    case iPhone6Plus
    case iPhoneX
    case iPhoneXsMax
    case iPhoneXr
}


class MatchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    let disposeBag = DisposeBag()
    
    var matchArrayResults: Results<MatchModel>?
    
    var matchList = List<MatchModel>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
       

        self.collectionView.register(UINib.init(nibName: "MatchViewCell", bundle: nil), forCellWithReuseIdentifier: "MatchViewCell")
        
        let realm = try! Realm()
        
        self.matchArrayResults = realm.objects(MatchModel.self)
        
        if !(self.matchArrayResults?.isEmpty)! {
            let converted = self.matchArrayResults!.reduce(List<MatchModel>()) { (list, element) -> List<MatchModel> in
                list.append(element)
                return list
            }
            self.matchList = converted
            self.collectionView.reloadData()
        }
        
        
        
        SteamAPI.shared.getMatchs().observeOn(MainScheduler.instance)
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        .subscribe(
            onNext: { [weak self] matchArray in
                // Store value
//                self?.matchArray = matchArray
              
                self?.matchList.removeAll()
                let realm = try! Realm()
                
                try! realm.write {
//                    realm.add(matchArray, update: true)
                    realm.add(matchArray, update: true)
                }
                self?.matchList.append(objectsIn: matchArray)
                self?.collectionView.reloadData()
            },
            onError: { [weak self] error in
                // Present error
            }
            )
            .disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.matchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let matchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchViewCell", for: indexPath) as? MatchViewCell {
            
            let time =  self.matchList[indexPath.row].time ?? ""
            let teamOneImageId = self.matchList[indexPath.row].teamOneImage ?? ""
            let teamTwoImageId = self.matchList[indexPath.row].teamTwoImage ?? ""
            let teamOneName = self.matchList[indexPath.row].teamOneName ?? ""
            let teamTwoName = self.matchList[indexPath.row].teamTwoName ?? ""
            let BO = self.matchList[indexPath.row].BO ?? ""
         
            matchCell.setup(time: time, teamOneImage: teamOneImageId, teamTwoImage: teamTwoImageId, teamOneName: teamOneName, teamTwoName: teamTwoName, BO: BO)
          
        
            cell = matchCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceType = self.getDevice()
        let orientation = UIDevice.current.orientation
        
        if (deviceType == .iPhoneX || deviceType == .iPhoneXsMax || deviceType == .iPhoneXr) && (orientation == .landscapeLeft || orientation == .landscapeRight) {
            return CGSize(width: view.frame.width - 100, height: 145)
        } else {
            return CGSize(width: view.frame.width , height: 145)
        }
       
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: {
            _ in
            self.collectionView?.collectionViewLayout.invalidateLayout()
        })
    }
    
    
    func getDevice() -> iphoneType {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                return .iPhone5
            case 1334:
                print("iPhone 6/6S/7/8")
                return .iPhone6
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                return .iPhone6Plus
            case 2436:
                print("iPhone X, Xs")
                return .iPhoneX
            case 2688:
                print("iPhone Xs Max")
                return .iPhoneXsMax
            case 1792:
                print("iPhone Xr")
                return .iPhoneXr
            default:
                print("unknown")
                
            }
        }
        return .iPhone5
    }


}
