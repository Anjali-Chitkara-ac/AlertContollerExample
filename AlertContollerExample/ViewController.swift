//
//  ViewController.swift
//  AlertContollerExample
//
//  Created by Anjali Chitkara on 10/7/21.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var lblStock: UILabel!
    
    var globalTextField : UITextField? //placeholder

    override func viewDidLoad() {
        super.viewDidLoad()
        let stock = Stock()
        stock.symbol = "MSFT"
        stock.price = 300.00
        stock.volume = 16697017
        
        do {
            let realm = try Realm()
            print(Realm.Configuration.defaultConfiguration.fileURL)
            try realm.write{
                //realm.add(stock)
                realm.add(stock, update: .modified)
            }
        }
        catch {
            print("Error adding to the database \(error)")
        }
    }

    @IBAction func getAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Add alert controller", message: "Stock Symbol", preferredStyle: .alert)
        
        let OKButton = UIAlertAction(title: "OK", style: .default) { action in
            print("I am inside OK")
            self.lblStock.text = self.globalTextField?.text
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("I am inside cancel")
        }
        
        alertController.addAction(OKButton)
        alertController.addAction(cancelButton)
        
        alertController.addTextField { stockTextField in
            stockTextField.placeholder = "Stock Symbol"
            self.globalTextField = stockTextField
            
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
}

