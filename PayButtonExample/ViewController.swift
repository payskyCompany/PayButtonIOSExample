//
//  ViewController.swift
//  PayButtonExample
//
//  Created by mac on 2/10/20.
//  Copyright © 2020 PaySky. All rights reserved.
//

import UIKit
import PayButton

class ViewController: UIViewController, PaymentDelegate  {

    var receipt: TransactionStatusResponse = TransactionStatusResponse()
    func finishSdkPayment(_ receipt: TransactionStatusResponse) {
        self.receipt = receipt
        if receipt.Success {

            LabeResoinse.setTitle("Transaction completed successfully, click here to show callback result", for: .normal)
            
        }else {
            LabeResoinse.setTitle("Transaction has been failed click to callback callback ", for: .normal)


            
        }
    }
    @IBOutlet weak var LabeResoinse: UIButton!
    @IBOutlet weak var ChangeLang: UIButton!
    
    @IBOutlet weak var PayBtn: UIButton!
    @IBOutlet weak var CurrencyEd: UITextField!
    @IBOutlet weak var CurrencyLabel: UILabel!
    @IBOutlet weak var AmountEd: UITextField!
    @IBOutlet weak var AmountLabel: UILabel!
    @IBOutlet weak var TerminalIDTF: UITextField!
    @IBOutlet weak var TerminalIDLabel: UILabel!
    @IBOutlet weak var MerchantIdEd: UITextField!
    @IBOutlet weak var MerchantIdLabel: UILabel!
    @IBOutlet weak var AppName: UILabel!
    
    @IBOutlet weak var RefLabel: UILabel!
    
    @IBOutlet weak var RefValue: UITextField!
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
   
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")

              //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
              //tap.cancelsTouchesInView = false

              view.addGestureRecognizer(tap)
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
                   NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        
        
        ChangeLang.setTitle("change lang", for: .normal)
          PayBtn.setTitle("pay now", for: .normal)
          PayBtn.layer.cornerRadius = PaySkySDKColor.RaduisNumber
        
        MerchantIdEd.text = "51513"// set your merchant id here
        MerchantIdLabel.text = "Merchant ID paysky"

        RefValue.text = "3424324234"
        RefLabel.text = "ref number"
        
        
        TerminalIDTF.text = "36661607" // set your terminal id here
        TerminalIDLabel.text =  "Terminal ID paysky"
        
        AmountEd.text = "20"// set your amount here
        AmountLabel.text = "Amount"

        
        CurrencyLabel.text = "Currency paysky"
        AppName.text = "app name paysky"
        CurrencyEd.text = "818"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func PayAction(_ sender: Any) {
        
     
        if (MerchantIdEd.text?.isEmpty)! {
            view.makeToast( "please entre merchant")
            return
        }
        
        if (TerminalIDTF.text?.isEmpty)! {
            view.makeToast( "please entre terminal")
            return
        }
        
        if (AmountEd.text?.isEmpty)! {
            view.makeToast( "please entre amount")
            return
        }
        
        
        if (CurrencyEd.text?.isEmpty)! {
            view.makeToast( "please entre currency")
            return
        }
        
        

        let paymentViewController = PaymentViewController ()
        paymentViewController.amount =  AmountEd.text!
        paymentViewController.delegate = self
        paymentViewController.refnumber = RefValue.text ?? ""

        paymentViewController.mId = MerchantIdEd.text!
        paymentViewController.tId = TerminalIDTF.text!
        paymentViewController.Currency = CurrencyEd.text!
        paymentViewController.isProduction = false   // set it true if you want to go live



        paymentViewController.Key = "31623434616334632D306463612D343036632D613563362D653239653263633439303765" // set your secure hash key here

        paymentViewController.pushViewController()
        
        
    }

    
}

