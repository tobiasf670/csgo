//
//  ShowProPlayersViewController.swift
//  csStats
//
//  Created by Tobias Frantsen on 03/12/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//
import RxSwift
import RealmSwift
import UIKit

class ShowProPlayersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    let disposeBag = DisposeBag()
    
    var teamArrayResults: Results<TeamModel>?
    
    var teamList = List<TeamModel>()

    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self 

        self.collectionView.register(UINib.init(nibName: "ProPlayerCell", bundle: nil), forCellWithReuseIdentifier: "ProPlayerCell")
        
        self.collectionView.register(UINib(nibName: "SectionHeadeView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeadeView")
        
        let realm = try! Realm()
        
        self.teamArrayResults = realm.objects(TeamModel.self)
        
        
        
        if self.teamArrayResults?.isEmpty ?? true {
            self.getTeam(withId: "6665")
            self.getTeam(withId: "4608")
            self.getTeam(withId: "5973")
            self.getTeam(withId: "6667")
            self.getTeam(withId: "9215")
        } else {
            let converted = self.teamArrayResults!.reduce(List<TeamModel>()) { (list, element) -> List<TeamModel> in
                list.append(element)
                return list
            }
            self.teamList = converted
        }
        
       
        
   

        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return self.teamArray.count
        return self.teamList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
//        var playerArray = self.teamArray[indexPath.section].players
        let playerArray = self.teamList[indexPath.section].players
        if let proPlayerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProPlayerCell", for: indexPath) as? ProPlayerCell {
            
            let name = playerArray[indexPath.row].name!
            let id = playerArray[indexPath.row].id!
            
            proPlayerCell.setup(name: name, imageID: id)
            cell = proPlayerCell
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let deviceType = self.getDevice()
        let orientation = UIDevice.current.orientation
        
        if (deviceType == .iPhoneX || deviceType == .iPhoneXsMax || deviceType == .iPhoneXr) && (orientation == .landscapeLeft || orientation == .landscapeRight) {
           return CGSize(width: view.frame.width - 100 , height: 100)
        } else {
             return CGSize(width: view.frame.width , height: 100)
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeadeView", for: indexPath) as? SectionHeadeView {
            let name = self.teamList[indexPath.section].name!
            let logo = self.teamList[indexPath.section].logo!
            sectionHeader.setup(name: name, logoURL: logo)
            sectionHeader.backgroundColor = .red
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        debugPrint(view.frame.width)
        return CGSize(width: view.frame.width , height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowStatsCollectionViewController") as? ShowStatsCollectionViewController {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
    }
    }
   
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: {
            _ in
            self.collectionView?.collectionViewLayout.invalidateLayout()
        })
    }
    
    
    func getTeam(withId: String) {
        SteamAPI.shared.getProPlayers(withTeamID: withId ).observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(
                onNext: { [weak self] team in
                    // Store value
                    debugPrint("HELLO")
//                    self?.teamArrayR.append(team)
//                    self?.teamArrayR.append
                   
                    
                    let realm = try! Realm()
                    
                    try! realm.write {
                        realm.add(team, update: true)
                    }
                    self?.teamList.append(team)
                     self?.collectionView.reloadData()
                },
                onError: { [weak self] error in
                    // Present error
                }
            )
            .disposed(by: disposeBag)

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
    
    /*collectionView:layout:referenceSizeForHeaderInSection
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
  
}
