//
//  ViewController.swift
//  PayButtonExample
//
//  Created by mac on 2/10/20.
//  Copyright © 2020 PaySky. All rights reserved.
//

import UIKit
import PayButton

class ViewController: UIViewController {
    
    @IBOutlet weak var transactionStatusLabel: UIButton!
    @IBOutlet weak var AppName: UILabel!
    @IBOutlet weak var MerchantIdEd: UITextField!
    @IBOutlet weak var MerchantIdLabel: UILabel!
    @IBOutlet weak var TerminalIDTF: UITextField!
    @IBOutlet weak var TerminalIDLabel: UILabel!
    @IBOutlet weak var AmountEd: UITextField!
    @IBOutlet weak var AmountLabel: UILabel!
    @IBOutlet weak var CurrencyEd: UITextField!
    @IBOutlet weak var CurrencyLabel: UILabel!
    @IBOutlet weak var RefLabel: UILabel!
    @IBOutlet weak var RefValue: UITextField!
    @IBOutlet weak var PayBtn: UIButton!
    @IBOutlet weak var ChangeLang: UIButton!
    
    var receipt: TransactionStatusResponse = TransactionStatusResponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        AppName.text = "PaySky PayButton SDK"
        
        MerchantIdLabel.text = "Merchant ID"
        MerchantIdEd.text = "17685499712"  // set your merchant id here
        
        TerminalIDLabel.text =  "Terminal ID"
        TerminalIDTF.text = "92539221" // set your terminal id here
        
        AmountLabel.text = "Amount"
        AmountEd.text = "50.50" // set your amount here
        
        RefLabel.text = "Trxn Ref Number"
        RefValue.text = "732432535"  // set a unique number for your transaction
        
        CurrencyLabel.text = "Currency Code"
        CurrencyEd.text = "784"      // set country currency code, e.g. Egypt is 818
        
        PayBtn.setTitle("Pay Now", for: .normal)
        PayBtn.layer.cornerRadius = PaySkySDKColor.RaduisNumber
        
        ChangeLang.setTitle("Change Lang", for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func PayAction(_ sender: UIButton) {
        if (MerchantIdEd.text?.isEmpty)! {
            view.makeToast( "please enter merchant id")
            return
        }
        
        if (TerminalIDTF.text?.isEmpty)! {
            view.makeToast( "please enter terminal id")
            return
        }
        
        if (AmountEd.text?.isEmpty)! {
            view.makeToast( "please enter amount")
            return
        }
        
        if (CurrencyEd.text?.isEmpty)! {
            view.makeToast( "please enter currency code")
            return
        }
        
        let paymentViewController = PaymentViewController()
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
    
    @IBAction func didTapTransactionStatusLabel(_ sender: UIButton) {
        if receipt.Success {
            print(receipt)
        }
    }
    
}

extension ViewController: PaymentDelegate  {
    
    func finishSdkPayment(_ receipt: TransactionStatusResponse) {
        self.receipt = receipt
        if receipt.Success {
            transactionStatusLabel.setTitle("Transaction completed successfully, click here to show callback result", for: .normal)
        } else {
            transactionStatusLabel.setTitle("Transaction has been failed click to callback callback ", for: .normal)
        }
    }
    
}
