<p align="center"><a href="https://paysky.io/" target="_blank"><img width="440" src="https://paysky.io/wp-content/uploads/2021/05/PaySky-logo.svg"></a></p>

# PaySky PayButton SDK Usage Example
The PayButton helps make the integration of card acceptance into your app easy.

You simply provide the merchant information you receieve from PaySky to the payment SDK. The PayButton displays a ready-made view that guides the merchant through the payment process and shows a Summary screen at the end of the transaction.

### Getting Started

### Prerequisites
This project uses cocoapods for dependencies management. If you don't have cocoapods installed in your machine, or are using older version of cocoapods, you can install it in terminal by running command ```sudo gem install cocoapods```. For more information go to https://cocoapods.org/

1. Download CocoaPods on your machine if you don't already have it
```
sudo gem install cocoapods
```

2. Create a Podfile to your project.
```
pod init
```

3. Install third-party libraries using `pod`
```
pod install
```

## 💻 Installation

1. Add the pod to your Podfile:
```
pod 'PayButton'
```

2. Open the terminal and run
```
pod deintegrate
pod clean
pod install
```

## 🚀 Deployment
1. Before deploying your project live, you should get a merchant ID and terminal ID from our company.
2. You should keep your merchant ID and terminal ID secured in your project, encrypt them before save them in project.

## 🛠 How to use
In order to use the SDK you should get a Merchant ID, a Terminal ID and Secure Hash from PaySky company.

### 👉 Import
In the class you want to intiate the payment from, you should import the framework
```swift
import PayButton
```

After the import, create a new instance from PayButton
```swift
let paymentViewController = PaymentViewController()
```

and intialize the following data in the PayButton instance:-
1) Merchat id
2) Terminal id
3) Secure hash
4) Transaction reference number
5) Payment amount
6) Currency code

```swift
paymentViewController.delegate = self                 // Payment Delegate
paymentViewController.mId = "merchantId"              // Merchant id
paymentViewController.tId = "terminalId"              // Terminal id
paymentViewController.Key = "Merchant secure hash"    // Merchant secrue hash
paymentViewController.refnumber = "reference number"  // Generate unique 16-digits number
paymentViewController.amount =  "amount"              // Amount
paymentViewController.Currency = "currencyCode"       // Currency Code
paymentViewController.pushViewController()
```

In order to create transaction callback in delegate PaymentDelegate, implement delegate on your ViewController.

```swift 
    class ViewController: UIViewController, PaymentDelegate  {
        func finishSdkPayment(_ receipt: TransactionStatusResponse) {
           if receipt.Success {                  // if transaction success is true
               print("Transaction completed successfully")
               print(receipt.NetworkReference)           // reference number of transaction.
           } else {
               print("Transaction failed")
               print(receipt.Message)           // response error
           }
        }
    }
```

## 🛠️ Built With
* [Alamofire](https://github.com/Alamofire/Alamofire)  
* [EVReflection](https://github.com/evermeer/EVReflection)  


## ✍️ Authors
**PaySky Company** - (https://www.paysky.io)
