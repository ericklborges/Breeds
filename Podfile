platform :ios, '14.0'
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'

target 'Breeds' do
  pod 'Alamofire', '~> 5.2'
  pod 'Kingfisher', '~> 5.15.5'
  pod 'SwiftLint', '0.39.2'
  
  plugin 'cocoapods-keys', {
    :project => "Breeds",
    :keys => [
      "TheDogAPIKey"
    ]
  }
  
  target 'BreedsTests' do
    inherit! :search_paths
    pod 'Quick', '~> 3.0'
    pod 'Nimble', '~> 8.1.1'
    pod 'Nimble-Snapshots', '~> 8.2.1'
  end
  
#  target 'BreedsWidgetExtension' do
#    inherit! :search_paths
#  end
end

