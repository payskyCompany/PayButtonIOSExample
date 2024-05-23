<p align="center"><a href="https://paysky.io/" target="_blank"><img width="440" src="https://paysky.io/wp-content/uploads/2023/12/Paysky-logo.png"></a></p>

# PaySky PayButton SDK Example
The PayButton helps make the integration of card acceptance into your app easy.

You simply provide the merchant information you receieve from PaySky to the payment SDK. The PayButton displays a ready-made view that guides the merchant through the payment process and shows a summary screen at the end of the transaction.

### Getting Started

### Prerequisites
This project uses cocoapods for dependencies management. If you don't have cocoapods installed in your machine, or are using older version of cocoapods, you can install it in terminal by running command ```sudo gem install cocoapods``` or ```brew install cocoapods```. 
For more information go to [Cocoapods.org](https://guides.cocoapods.org/using/getting-started.html)

## 💻 Installation
1. Close Xcode project.
2. Create a Podfile to your project.
**From the terminal** navigate to project location then use next command
```
pod init
```
3. Add the pod to your Podfile:
**Open Podfile** with any text editor tool then add the next line inside "target 'PayButton' do "scoop 
```
pod 'PayButtonIOS', :git => 'https://github.com/payskyCompany/PayButtonIOS.git', :branch => 'master'
```
4. Open the terminal and run
```
pod deintegrate
pod install
```
##### ﹢ Optional step (recommended)
To avoid pods `DEPLOYMENT_TARGET` errors add the next lines to the end of podFile
```
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
```

5. Disable ```USER_SCRIPT_SANDBOXING```
    1. Reopen _.xcworkspace.
    2. Navigate to **targets** and select your app name.
    3. Navigate to Build Settings
    4. Search for USER_SCRIPT_SANDBOXING and set it to **NO**.
<a href="https://raw.githubusercontent.com/payskyCompany/PayButtonIOS/develop/Screenshot%202024-05-20%20at%204.14.24%E2%80%AFPM.png">
    <img src="https://raw.githubusercontent.com/payskyCompany/PayButtonIOS/develop/Screenshot%202024-05-20%20at%204.14.24%E2%80%AFPM.png" />
</a>

### ⚠️ Addition step 
If you have this error : 
 ```
Multiple commands produce '/Users/paysky106/Library/Developer/Xcode/
DerivedData/TestPayButton-ghdftwdswnoxgexfnpfxqmwsgah/Build/Products/
Debug-iphonesimulator/TestPayButton.app/Assets.car'
 ```
 <br />
Place disable_input_output_paths: true in Podfile, to skip optimisation and always download resources from Pods cleanly every time, since it is not copying bundled assets during build. Adding extra overhead to build doesn't seem optimal, and leads to bad experience during local App development

```
# Podfile
# platform :ios, '13.0'
install! 'cocoapods', :disable_input_output_paths => true
```
## 🚀 Deployment
1. Before deploying your project live, you should get a merchant ID and terminal ID provided by PaySky.
2. You should keep your merchant ID and terminal ID **secured** in your project, **encrypt** them before save them in project.

## 🛠 How to use
In order to use the SDK you should use a production merchantId, terminalId and secure_hash key provided by PaySky.

### 👉 Usage/Examples 
In the class you want to intiate the payment from, you should import the framework
```swift
import PayButton
```

After the import, create a new instance from PayButton
```swift
let paymentViewController = PaymentViewController(
                merchantId: "merchantId", //Mandatory
                terminalId: "terminalId", //Mandatory
                amount: 100.0, //Mandatory - provide the amount and currency with it's decimal factor
                currencyCode: 0, //Mandatory - Provided by PaySky
                secureHashKey: "secure_hash",//Mandatory - Provided by PaySky
                trnxRefNumber: "", //Optinal (remove it if not use), Provided by PaySky
                customerId: "", //Optinal (remove it if not use), Provided by PaySky
                customerMobile: "", //Optinal (remove it if not use), Provided by PaySky
                customerEmail: "", //Optinal (remove it if not use), Provided by PaySky
                isProduction: false //Choose the needed inviroment
            )
```

Then confirm to **PaymentDelegate** :-
```swift
paymentViewController.delegate = self // Payment Delegate
paymentViewController.pushViewController()
```

In order to create transaction callback in delegate PaymentDelegate, implement delegate on your ViewController.

```swift 
extension ViewController: PayButtonDelegate {
    func finishedSdkPayment(_ response: PayButton.PayByCardReponse) {
        if response.success == true {
            print("Transaction completed successfully")
            print(response.networkReference ?? "") // reference number of transaction.
        } else {
            print("Transaction failed")
            print(response.message ?? "") // response error
        }
    }
}
```

## 🛠️ Built With
* [Alamofire](https://github.com/Alamofire/Alamofire)  
* [PopupDialog](https://github.com/orderella/PopupDialog)
* [PayCardsRecognizer](https://github.com/faceterteam/PayCards_iOS/blob/master/PayCardsRecognizer.podspec)
* [MOLH](https://github.com/MoathOthman/MOLH)

## ✍️ Authors
**PaySky Company**

<a href="https://www.paysky.io">
  <img src="https://paysky.io/wp-content/uploads/2023/12/Paysky-logo.png" alt="paysky" height="50">
</a>


## 🔗 Links

<a href="https://www.paysky.io">
  <img src="https://paysky.io/wp-content/uploads/2023/12/Paysky-logo.png" alt="paysky" height="50">
</a> <a href="https://www.linkedin.com/company/paysky">
  <img src="https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" alt="paysky" height="40">
</a>


## 👀 SDK Repo
[PayButtonIOS SDK](https://github.com/payskyCompany/PayButtonIOS.git)
