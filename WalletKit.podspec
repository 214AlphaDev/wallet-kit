Pod::Spec.new do |s|
  s.name          = "WalletKit"
  s.version       = "0.0.1"
  s.summary       = "SDK that provides wallet related functionality to build 214 alpha applications."
  s.license       = { }
  s.homepage      = "https://github.com/214alphadev/wallet-kit"
  s.author        = { "Andrii Selivanov" => "seland@214alpha.com" }
  s.platform      = :ios, "11.0"
  s.source        = { :git => "git@github.com:214alphadev/wallet-kit.git" }
  s.source_files  = "WalletKit/**/*.swift"
  s.framework     = "UIKit"
  s.dependency 'Apollo', '0.10.0'
  s.dependency 'FlowKit', '0.0.2'
  s.dependency 'web3swift', '>= 2.1.10'
  s.dependency 'KeychainAccess', '3.1.2'
  s.dependency 'CommunityKit', '0.0.2'
end
