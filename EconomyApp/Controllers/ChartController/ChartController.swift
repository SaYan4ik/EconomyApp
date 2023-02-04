//
//  ChartController.swift
//  EconomyApp
//
//  Created by Александр Янчик on 4.02.23.
//

import UIKit
import Charts

class ChartController: UIViewController {
    @IBOutlet weak var chartView: PieChartView!
    
    private var allSavings = [SavingsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setGradientBackground()
        getData()
        setupPieView()
    }
    
    private func getData() {
        allSavings = RealmManager<SavingsModel>().read()
    }
    
    private func setupPieView() {
//        chartView.chartDescription?.enabled = false
//        chartView.drawHoleEnabled = true
//        chartView.rotationAngle = 10
//        chartView.rotationEnabled = true
//        chartView.isUserInteractionEnabled = true
//        chartView.chartDescription?.textColor = .white
//        chartView.chartDescription?.text = "All you savings and deposits"
//        chartView.holeColor = .clear
        chartView.centerText = "All you savings and deposits"
        
        
        var entrie = [PieChartDataEntry]()
        
        for index in 0..<allSavings.count {
            guard let doublCurency = Double(allSavings[index].currency),
                  let type = allSavings[index].typeValue?.type
            else { return }
            
            let dataEntry = PieChartDataEntry(value: doublCurency, label: type)
            entrie.append(dataEntry)
        }
        let dataSet = PieChartDataSet(entries: entrie)
        
//        dataSet.colors = colorsOfCharts(numbersOfColor: allSavings.count)
        
        dataSet.colors = ChartColorTemplates.colorful()
        chartView.backgroundColor = .clear
        
        chartView.data = PieChartData(dataSet: dataSet)
        
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
      var colors: [UIColor] = []
      for _ in 0..<numbersOfColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
      }
      return colors
    }
    
    
}
