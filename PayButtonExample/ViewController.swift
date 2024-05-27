//
//  ViewController.swift
//  PayButtonExample
//
//  Created by mac on 2/10/20.
//  Copyright © 2020 PaySky. All rights reserved.
//

import PayButtonIOS
import UIKit

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

    var receipt: PayByCardReponse?

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(_dismissKeyboard))
        view.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        AppName.text = "PaySky PayButton SDK"

        MerchantIdLabel.text = "Merchant ID"
        MerchantIdEd.text = "49660" // set your merchant id here

        TerminalIDLabel.text = "Terminal ID"
        TerminalIDTF.text = "32731520" // set your terminal id here

        AmountLabel.text = "Amount"
        AmountEd.text = "50.50" // set your amount here

        RefLabel.text = "Trxn Ref Number"
        RefValue.text = "732432535" // set a unique number for your transaction

        CurrencyLabel.text = "Currency Code"
        CurrencyEd.text = "818" // set country currency code, e.g. Egypt is 818

        PayBtn.setTitle("Pay Now", for: .normal)
        PayBtn.layer.cornerRadius = 10

        ChangeLang.setTitle("Change Lang", for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func PayAction(_ sender: UIButton) {
        if (MerchantIdEd.text?.isEmpty)! { return }

        if (TerminalIDTF.text?.isEmpty)! { return }

        if (AmountEd.text?.isEmpty)! { return }

        if (CurrencyEd.text?.isEmpty)! { return }

        let paymentViewController = PaymentViewController(
            merchantId: MerchantIdEd.text!, // Mandatory
            terminalId: TerminalIDTF.text!, // Mandatory
            amount: Double(AmountEd.text ?? "0.0") ?? 0, // Mandatory - provide the amount and currency with it's decimal factor
            currencyCode: Int(CurrencyEd.text!) ?? 0, // Mandatory - Provided by PaySky
            secureHashKey: "57d29e75443b0f2ef4a1d83adfb1ab3d", // Mandatory - Provided by PaySky
            trnxRefNumber: RefValue.text ?? "",
            isProduction: false // Choose the needed environment
        )

        paymentViewController.delegate = self // Payment Delegate
        paymentViewController.pushViewController()
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }

    @objc func _dismissKeyboard() {
        // Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    @IBAction func didTapTransactionStatusLabel(_ sender: UIButton) {
        if receipt?.success == true {
            print(receipt)
        }
    }
}

extension ViewController: PayButtonDelegate {
    func finishedSdkPayment(_ response: PayButtonIOS.PayByCardReponse) {
        self.receipt = response
        
        if response.success == true {
            transactionStatusLabel.setTitle("Transaction completed successfully, click here to show callback result", for: .normal)
            navigationController?.popViewController(animated: true)
        } else {
            transactionStatusLabel.setTitle("Transaction has been failed click to callback callback ", for: .normal)
        }
    }
}
