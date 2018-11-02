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
    
    public func getStats() -> Observable<[SteamModel]> {
        return Observable.create { observer -> Disposable in
            
             Alamofire.request("https://api.steampowered.com/ISteamUserStats/GetUserStatsForGame/v0002/?appid=730&key=12A1D1DE83F9932934EDD6DF2BA00463&steamid=76561197998840550")
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        
                       let json = JSON(response.data!)
                       let array = SteamModel.parse(json: json)
                        
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
    
//
//    func getFriends() -> Observable<[Friend]> {
//        return Observable.create { observer -> Disposable in
//            Alamofire.request("http://friendservice.herokuapp.com/listFriends")
//                .validate()
//                .responseJSON { response in
//                    switch response.result {
//                    case .success:
//                        guard let data = response.data else {
//                            // if no error provided by alamofire return .notFound error instead.
//                            // .notFound should never happen here?
//                            observer.onError(response.error ?? GetFriendsFailureReason.notFound)
//                            return
//                        }
//                        do {
//                            let friends = try JSONDecoder().decode([Friend].self, from: data)
//                            observer.onNext(friends)
//                        } catch {
//                            observer.onError(error)
//                        }
//                    case .failure(let error):
//                        if let statusCode = response.response?.statusCode,
//                            let reason = GetFriendsFailureReason(rawValue: statusCode)
//                        {
//                            observer.onError(reason)
//                        }
//                        observer.onError(error)
//                    }
//            }
//
//            return Disposables.create()
//        }
//    }
}
