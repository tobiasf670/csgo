//
//  ShowProPlayersViewController.swift
//  csStats
//
//  Created by Tobias Frantsen on 03/12/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//
import RxSwift
import UIKit

class ShowProPlayersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
   
    
   
    

    
    let disposeBag = DisposeBag()
    
    var teamArray : [TeamModel] = [TeamModel]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self 

        self.collectionView.register(UINib.init(nibName: "ProPlayerCell", bundle: nil), forCellWithReuseIdentifier: "ProPlayerCell")
        
        self.collectionView.register(UINib(nibName: "SectionHeadeView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeadeView")
        
        self.getTeam(withId: "6665")
        self.getTeam(withId: "4608")
        self.getTeam(withId: "5973")
        self.getTeam(withId: "6667")
        self.getTeam(withId: "9215")
        
   

        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.teamArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        var playerArray = self.teamArray[indexPath.section].players
        if let proPlayerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProPlayerCell", for: indexPath) as? ProPlayerCell {
            
            let name = playerArray[indexPath.row].name!
            let id = playerArray[indexPath.row].id!
            
            proPlayerCell.setup(name: name, imageID: id)
            cell = proPlayerCell
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeadeView", for: indexPath) as? SectionHeadeView {
            let name = self.teamArray[indexPath.section].name!
            let logo = self.teamArray[indexPath.section].logo!
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
   
    
    
    func getTeam(withId: String) {
        SteamAPI.shared.getProPlayers(withTeamID: withId ).observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(
                onNext: { [weak self] team in
                    // Store value
                    debugPrint("HELLO")
                    self?.teamArray.append(team)
                    self?.collectionView.reloadData()
                },
                onError: { [weak self] error in
                    // Present error
                }
            )
            .disposed(by: disposeBag)

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
