//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Modified by Abdul Diallo on 12/28/2019
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    var coinManager = CoinManager()
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var pickerLabel: UIPickerView!
    @IBOutlet weak var askPrice: UILabel!
    @IBOutlet weak var bidPrice: UILabel!
    @IBOutlet weak var lowPrice: UILabel!
    @IBOutlet weak var highPrice: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerLabel.dataSource = self
        pickerLabel.delegate = self
        coinManager.delegate = self
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = coinManager.currencyArray[row]
        coinManager.returnPrice(currency)
    }

}


//MARK: - CoinManagerDelegate

extension ViewController : CoinManagerDelegate {
    func failedWithError(error: Error) {
        print(error)
    }
    
    func updatedPrice(price: CoinGroup, currency: String) {
        DispatchQueue.main.async {
            self.priceLabel.text = price.last
            self.currencyLabel.text = currency
            self.askPrice.text = price.ask
            self.bidPrice.text = price.bid
            self.highPrice.text = price.high
            self.lowPrice.text = price.low
        }
    }
    
}




