//
//  BarChartViewCell.swift
//  csStats
//
//  Created by Tobias Frantsen on 08/11/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//

import Charts
import UIKit

class BarChartViewCell: UICollectionViewCell {

    @IBOutlet weak var barChartView: BarChartView!
    
    var barChartDataSet = [BarChartDataSet]()
    override func awakeFromNib() {
        super.awakeFromNib()
      self.barChartView.drawValueAboveBarEnabled = true
        self.barChartView.fitBars = true
        
    }

    
    func setup(stats: [StastModel]?) {
        guard let statsArray = stats else {
            return
        }
        for stats in statsArray {
         
            switch stats.name! {
            case StatsType.total_kills_knife.rawValue:
                if let yValue = stats.value.value {
                    self.addBarChartDataToArray(yValue: Double(yValue), name: "Knife KILLS")
                }
            case StatsType.total_kills_glock.rawValue:
                if let yValue = stats.value.value {
                    self.addBarChartDataToArray(yValue: Double(yValue), name: "Glock KILLS")
                }
            case StatsType.total_kills_deagle.rawValue:
                if let yValue = stats.value.value {
                    self.addBarChartDataToArray(yValue: Double(yValue), name: "Deagle KILLS")
                }
            case StatsType.total_kills_ak47.rawValue:
                if let yValue = stats.value.value {
                    self.addBarChartDataToArray(yValue: Double(yValue), name: "AK47 KILLS")
                }
            case StatsType.total_kills_awp.rawValue:
                if let yValue = stats.value.value {
                    self.addBarChartDataToArray(yValue: Double(yValue), name: "AWP KILLS")
                }
            case StatsType.total_kills_aug.rawValue:
                if let yValue = stats.value.value {
                    self.addBarChartDataToArray(yValue: Double(yValue), name: "AUG KILLS")
                }
                
            default:
                break
            }
        }
        self.updateCharts()
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
        
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
        data.barWidth = 0.9
        
        
        
        self.barChartView.data = data
        self.barChartView.dragYEnabled = true
    }
    
    func createRandomColor() -> [NSUIColor] {
        let randomRed = CGFloat.random(in: 0...255)
        let randomGreen = CGFloat.random(in: 0...255)
        let randomBlue = CGFloat.random(in: 0...255)
        return [NSUIColor(red: randomRed/255.0, green: randomGreen/255.0, blue: randomBlue/255.0, alpha: 1.0)]
    }
}
