# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'PayButtonExample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  source 'https://github.com/payskyCompany/PayButtonIOS.git'
  source 'https://cdn.cocoapods.org/'

  # Pods for PayButtonExample
  pod 'PayButton'
  
  post_install do |installer|
    installer.generated_projects.each do |project|
      project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
      end
    end
  end
  
end
