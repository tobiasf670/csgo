//
//  StatsViewController.swift
//  csStats
//
//  Created by Tobias Frantsen on 02/11/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//
import RxSwift
import SimpleCheckbox
import Charts
import UIKit

class StatsViewController: UIViewController {

    @IBOutlet weak var totalKills: Checkbox!
    @IBOutlet weak var totalDeaths: Checkbox!
    
    @IBOutlet weak var piceChartView: BarChartView!
    @IBOutlet weak var showText: UILabel!
    let disposeBag = DisposeBag()
    var stats: [SteamModel]?
    var filters = [StatsType: Bool]()
    
    
//    var killsDataEntry = BarChartDataEntry(x: 0, y: 0)
//    var deathsDataEntry = BarChartDataEntry(x: 0, y: 0)
    
    var barChartArray = [String: BarChartDataEntry]()
    var barChartDataSet = [BarChartDataSet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.piceChartView.drawValueAboveBarEnabled = true
        
        
       
        
//        self.killsDataEntry.
//        self.killsDataEntry.label = "Kills"
//
//        self.deathsDataEntry.value = 48557
//        self.deathsDataEntry.label = "Deaths"
        
//        self.kda = [self.killsDataEntry, self.deathsDataEntry]
        
        
        self.totalKills.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
        
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
//            case total_kills_knife
//            case total_kills_glock
//            case total_kills_deagle
//            case total_kills_ak47
//            case total_kills_awp
//            case total_kills_aug
            switch stats.name! {
            case StatsType.total_kills_knife.rawValue:
                if let yValue = stats.value {
                    self.addBarChartDataToArray(yValue: Double(yValue), name: "Knife KILLS")
                }
            case StatsType.total_kills_glock.rawValue:
                if let yValue = stats.value {
                    self.addBarChartDataToArray(yValue: Double(yValue), name: "Glock KILLS")
                }
            case StatsType.total_kills_deagle.rawValue:
                if let yValue = stats.value {
                    self.addBarChartDataToArray(yValue: Double(yValue), name: "Deagle KILLS")
                }
            case StatsType.total_kills_ak47.rawValue:
                if let yValue = stats.value {
                    self.addBarChartDataToArray(yValue: Double(yValue), name: "AK47 KILLS")
                }
            case StatsType.total_kills_awp.rawValue:
                if let yValue = stats.value {
                    self.addBarChartDataToArray(yValue: Double(yValue), name: "AWP KILLS")
                }
            case StatsType.total_kills_aug.rawValue:
                if let yValue = stats.value {
                      self.addBarChartDataToArray(yValue: Double(yValue), name: "AUG KILLS")
                }
   
            default:
                break
            }
        }
    self.updateCharts()
    }
    
    @objc func checkboxValueChanged(sender: Checkbox) {
        print("checkbox value change: \(sender.isChecked)")
//        self.filters[.total_kills] = sender.isChecked
//        self.showTotalKills()
    }
    
    
    func addBarChartDataToArray(yValue: Double, name: String) {
        let xValue = self.barChartDataSet.count
        let newChartData = BarChartDataEntry(x: Double(xValue), y: Double(yValue))
        let newCharDataSet = BarChartDataSet(values: [newChartData], label: name)
        self.barChartDataSet.append(newCharDataSet)
        
    }
    
    func updateCharts() {

        for dataSet in self.barChartDataSet {
           dataSet.colors = self.createRandomColor()
        }
        
        let data = BarChartData(dataSets: self.barChartDataSet)
        
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 12)!)
        data.barWidth = 0.9
        
        self.piceChartView.data = data
    }
    
    func createRandomColor() -> [NSUIColor] {
        let randomRed = CGFloat.random(in: 0...255)
        let randomGreen = CGFloat.random(in: 0...255)
        let randomBlue = CGFloat.random(in: 0...255)
        return [NSUIColor(red: randomRed/255.0, green: randomGreen/255.0, blue: randomBlue/255.0, alpha: 1.0)]
    }

}
