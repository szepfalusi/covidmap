//
//  DetailViewController.swift
//  Covid19map
//
//  Created by Szépfalusi István on 2020. 12. 24..
//

import UIKit
import Charts

class DetailViewController: UIViewController{
    var country: String = ""
    var stats: [CountryStat] = []
    var statsforChart: [CountryStat] = []
    let pull = PullWithAPI()
    
    @IBOutlet var totalCases: UILabel!
    @IBOutlet var totalRecovered: UILabel!
    @IBOutlet var totalDeaths: UILabel!
    
    func showmesomeData(){
        if let obj = stats.first(where: {$0.name==country}){
            let anewconfirmed = statsforChart[statsforChart.endIndex-1].totalconfirmed! - statsforChart[statsforChart.endIndex-2].totalconfirmed!
            self.totalCases.text = String(obj.totalconfirmed!)+" (+"+String(anewconfirmed)+")"
            let arecovered = statsforChart[statsforChart.endIndex-1].totalrecovered! - statsforChart[statsforChart.endIndex-2].totalrecovered!
            self.totalRecovered.text = String(obj.totalrecovered!)+" (+"+String(arecovered)+")"
            let adeaths = statsforChart[statsforChart.endIndex-1].totaldeaths! - statsforChart[statsforChart.endIndex-2].totaldeaths!
            self.totalDeaths.text = String(obj.totaldeaths!)+" (+"+String(adeaths)+")"
        }else{
            print("Data is not available for this country.")
        }

    }
    
    func updateLineChart(stats: [CountryStat]){
        var dates: [String] = []
        var active: [Int] = []
        
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        for i in stats {
            var statsizecount = 0
            let statsize = stats.count
            if i.name != nil && i.date != nil && i.active != nil{
                
                active.append(i.active!)
                if statsizecount == 0 {
                    dates.append(formatter.string(from: i.date!))
                }
                if statsizecount == statsize/2 {
                    dates.append(formatter.string(from: i.date!))
                }
                if statsizecount == statsize{
                    dates.append(formatter.string(from: i.date!))
                }
                
            }
            statsizecount+=1
        }
        
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<active.count {
            let value = ChartDataEntry(x: Double(i-1), y: Double(active[i]))
            
            lineChartEntry.append(value)
            
        }
        let line1 = LineChartDataSet(entries: lineChartEntry, label: "Active cases")
        line1.colors = [NSUIColor.red]
        
        let data = LineChartData()
        
        line1.drawCirclesEnabled = false
        line1.drawValuesEnabled = false
        
        data.addDataSet(line1)
        
        
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:dates)
        lineChart.xAxis.granularity = 1
        lineChart.xAxis.labelCount = 3
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.drawAxisLineEnabled = false
        lineChart.data = data
        
    }
    
    func updatePieChart(){
        var recovered: Int = 0
        var deaths: Int = 0
        var active: Int = 0
        if let obj = stats.first(where: {$0.name==country}){
             recovered = obj.totalrecovered!
             deaths = obj.totaldeaths!
             active = obj.totalconfirmed! - recovered - deaths
        }else{
            print("Data is not available for this country.")
        }
        var totalrecoveredEntry = PieChartDataEntry(value: 0)
        var totaldeathsEntry = PieChartDataEntry(value: 0)
        var activeEntry = PieChartDataEntry(value: 0)
        var numberofDataEntries = [PieChartDataEntry]()
        
        totalrecoveredEntry.value = Double(recovered)
        totalrecoveredEntry.label = "Recovered"
        totaldeathsEntry.value = Double(deaths)
        totaldeathsEntry.label = "Deaths"
        activeEntry.value = Double(active)
        activeEntry.label = "Active cases"
        
        numberofDataEntries = [totalrecoveredEntry,totaldeathsEntry,activeEntry]
        
        let chartDataSet = PieChartDataSet(entries: numberofDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.systemGreen, UIColor.systemRed, UIColor.systemYellow]
        chartDataSet.colors = colors
        
        pieChart.data = chartData
    }
    
    @IBOutlet var lineChart: LineChartView!
    
    @IBOutlet var pieChart: PieChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = country

        statsforChart = pull.pullDailyCases(name: country, coarr: stats)
        showmesomeData()
        if statsforChart.first(where: {$0.name==country}) != nil {
            updateLineChart(stats: statsforChart)
            updatePieChart()
        }
        //updateLineChart(stats: statsforChart)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    

    
    
}
