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
    
    @IBOutlet weak var piceChartView: PieChartView!
    @IBOutlet weak var showText: UILabel!
    let disposeBag = DisposeBag()
    var stats: [SteamModel]?
    var filters = [StatsType: Bool]()
    
    
    var killsDataEntry = PieChartDataEntry(value: 0)
    var deathsDataEntry = PieChartDataEntry(value: 0)
    
    var kda = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.piceChartView.chartDescription?.text = ""
        
        self.piceChartView.centerText = "1.6 KDR"
        
        self.piceChartView.sizeToFit()
        
        
        self.killsDataEntry.value = 49557
        self.killsDataEntry.label = "Kills"
        
        self.deathsDataEntry.value = 48557
        self.deathsDataEntry.label = "Deaths"
        
        self.kda = [self.killsDataEntry, self.deathsDataEntry]
        
        self.updateCharts()
        
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
            if stats.name == StatsType.total_kills.rawValue {
                self.showText.text = String(stats.value!)
            }
        }
    
    }
    
    @objc func checkboxValueChanged(sender: Checkbox) {
        print("checkbox value change: \(sender.isChecked)")
        self.filters[.total_kills] = sender.isChecked
        self.showTotalKills()
    }
    
    func updateCharts() {
        let chartDataSet = PieChartDataSet(values: self.kda, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.black, UIColor.green]
        chartDataSet.colors = colors
        
        self.piceChartView.data = chartData
    }

}
