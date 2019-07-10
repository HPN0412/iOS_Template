platform :ios, '10.0'

# RxSwift
def rxSwift
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire', '4.8.1'
  pod 'AlamofireObjectMapper', '5.2.0'
end

# Swift
def swift
  pod 'Alamofire', '4.8.2'
  pod 'ObjectMapper', '3.5.1'
  pod 'AlamofireObjectMapper', '5.2.0'
  pod 'Socket.IO-Client-Swift'
  pod 'SwiftLint', '~> 0.33.1'
end

# UI
def libraryUI
  pod 'SVProgressHUD', '2.2.5'
  pod 'IQKeyboardManager'
  pod 'UIScrollView-InfiniteScroll'
  pod 'Kingfisher', '4.10.1'
  pod 'PureLayout', '3.1.4'
  pod 'Shimmer', '1.0.2'
end

# Tracking
def tracking
  pod 'Fabric'
  pod 'Crashlytics'
end

# Google
def google
  pod 'Google-Mobile-Ads-SDK'
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'Firebase/Auth'
  pod 'GoogleSignIn'
  pod 'Firebase/Core'
  pod 'Firebase/DynamicLinks'
end

# Utils
def utils
  pod 'SwifterSwift', '5.0.0'
  pod 'R.swift', '5.0.3'
  pod 'SwiftyUserDefaults', '4.0.0'
end

target 'iOSTemplate' do
  use_frameworks!

  swift
  utils
  libraryUI
end
