Pod::Spec.new do |spec|

  spec.name         = "Utils"
  spec.version      = "0.0.40"
  spec.summary      = "Utilities for fast, neat and convenient IOS-development"
  spec.description  = "Use handly utilities instead of creating by your own"
  spec.homepage     = "https://github.com/MobileUpLLC/Utils"

  spec.license      = "MIT"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author       = { "MobileUp iOS Team" => "hello@mobileup.ru" }

  spec.platform     = :ios, "13.0"
  spec.ios.frameworks = 'UIKit'
  spec.swift_version = ['5']

  spec.source = { :git => 'https://github.com/MobileUpLLC/Utils.git', :tag => spec.version.to_s }
  spec.source_files  = "Sources/", "Sources/**/*.{swift}"
end
