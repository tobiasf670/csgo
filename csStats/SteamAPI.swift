//
//  SteamAPI.swift
//  csStats
//
//  Created by Tobias Frantsen on 01/11/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//
import Alamofire
import SwiftyJSON
import RxSwift
import UIKit


class SteamAPI {
    
    static let shared = SteamAPI()
    
    public func getStats() -> Observable<[StastModel]> {
        return Observable.create { observer -> Disposable in
            
             Alamofire.request("https://api.steampowered.com/ISteamUserStats/GetUserStatsForGame/v0002/?appid=730&key=12A1D1DE83F9932934EDD6DF2BA00463&steamid=76561197998840550")
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        
                       let json = JSON(response.data!)
                       let array = StastModel.parse(json: json)
                        
                        //parse and return object 
                        observer.onNext(array)
                    case .failure(let error):
                        if (response.response?.statusCode) != nil
                        {
                            observer.onError(error)
                        }
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        
    }
    }
    
    
    public func getMatchs() -> Observable<[MatchModel]> {
        return Observable.create { observer -> Disposable in
            
            Alamofire.request("https://secret-inlet-64466.herokuapp.com/results")
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        
                        let json = JSON(response.data!)
                     
//                        let array = SteamModel.parse(json: json)
                        let array = MatchModel.parse(json: json)
                        
                        observer.onNext(array)
                        
                        //parse and return object
//                        observer.onNext(array)
                    case .failure(let error):
                        if (response.response?.statusCode) != nil
                        {
                            observer.onError(error)
                        }
                        observer.onError(error)
                    }
            }
            return Disposables.create()
            
        }
    }
    
    public func getProPlayers(withTeamID: String) -> Observable<TeamModel> {
        return Observable.create { observer -> Disposable in
        
            Alamofire.request("https://secret-inlet-64466.herokuapp.com/team/\(withTeamID)")
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        
                        let json = JSON(response.data!)
                     
                        let team = TeamModel.parse(json: json)
                        observer.onNext(team)
                      
                    case .failure(let error):
                        if (response.response?.statusCode) != nil
                        {
                            observer.onError(error)
                        }
                        observer.onError(error)
                    }
            }
            return Disposables.create()
            
        }
    }
    
}
