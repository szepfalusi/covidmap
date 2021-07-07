//
//  WorldViewController.swift
//  Covid19map
//
//  Created by István Szépfalusi on 2021. 01. 16..
//

import UIKit
import Charts

class WorldViewController: UIViewController {
    var stats: [CountryStat] = []
    
    func getGlobalData() -> [String: Int]{
        var globalarray: [String: Int] = [:]
        for i in stats {
            if i.name == nil {
                globalarray = ["totalrecovered" : i.totalrecovered!,
                               "totaldeaths" : i.totaldeaths!,
                               "totalcases" : i.totalconfirmed!,
                               "active" : i.active!
                                ]
            }
            return globalarray
        }
        return globalarray
    }
    
    
    @IBOutlet var pieChart: PieChartView!
    
    var totalrecoveredEntry = PieChartDataEntry(value: 0)
    var totaldeathsEntry = PieChartDataEntry(value: 0)
    var activeEntry = PieChartDataEntry(value: 0)
    
    var numberofDataEntries = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        updateChartData()
        
    }
    
    func updateChartData(){
        let globalData = getGlobalData()
        totalrecoveredEntry.value = Double(globalData["totalrecovered"]!)
        totalrecoveredEntry.label = "Recovered"
        totaldeathsEntry.value = Double(globalData["totaldeaths"]!)
        totaldeathsEntry.label = "Deaths"
        activeEntry.value = Double(globalData["active"]!)
        activeEntry.label = "Active cases"
        
        numberofDataEntries = [totalrecoveredEntry,totaldeathsEntry,activeEntry]
        
        let chartDataSet = PieChartDataSet(entries: numberofDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.systemGreen, UIColor.systemRed, UIColor.systemYellow]
        chartDataSet.colors = colors
        
        pieChart.data = chartData
    }
    


}
