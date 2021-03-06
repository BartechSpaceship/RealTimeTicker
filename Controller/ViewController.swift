//
//  ViewController.swift
//  RealTimeTicker
//
//  Created by Bartek on 3/12/20.
//  Copyright © 2020 Bartek. All rights reserved.
//


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Must call the coinManager delegate to recieve notifications when delegate methods are called
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        
    }
}
//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    //When the coin manager gets the price it will call this method and pass over the price and currency
    func didUpdatePrice(price: String, currency: String) {
           //Have to get a hold of the main thread to updateUI, otherwise the app will crash if we try to
           //do this from a background thread(URL session works in background)
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price // updating price
            self.currencyLabel.text = currency
        }
    }
       
       func didFailWithError(error: Error) {
           print(error)
    }
}
//MARK: - UIPickerView DataSource & Delegate
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
    
    
}

