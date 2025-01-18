# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

platform :ios, '12.0'

# ignore all warnings from all pods
inhibit_all_warnings!
use_frameworks!
install! 'cocoapods', :disable_input_output_paths => true

source 'https://bitbucket.org/ttbbank/one_oneapp-designsystem-ios-private-pods.git'
source 'https://github.com/CocoaPods/Specs.git'

target 'iOSUIKit' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'OneAppDesignSystem', '11.5.0'

  # Pods for iOSUIKit

  target 'iOSUIKitTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'iOSUIKitUITests' do
    # Pods for testing
  end

end
