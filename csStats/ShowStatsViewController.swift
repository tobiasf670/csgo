//
//  ShowStatsViewController.swift
//  csStats
//
//  Created by Tobias Frantsen on 28/09/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//
import Alamofire
import UIKit

class ShowStatsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("https://httpbin.org/get")
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                case .failure(let error):
                    print(error)
                }
        }

        // Do any additional setup after loading the view.
    
        func getData(){
            //API LINK: https://api.steampowered.com/ISteamUserStats/GetUserStatsForGame/v0002/?appid=730&key=12A1D1DE83F9932934EDD6DF2BA00463&steamid=76561197998840550
            // API LINK WITH USERNAME AND STREAMID : http://api.steampowered.com/ISteamUserStats/GetUserStatsForGame/v0002/?key=[APIKEY]&appid=730&steamid=[steamid]
            // Make model
            // Make parse
            // make a graph
            // input username
            // API link to pro mathces
            // GRAPH LIB: https://github.com/danielgindi/Charts
           
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
