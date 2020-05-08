platform :ios, '11.0'

target 'WalletKit' do
  use_frameworks!
  pod 'Apollo', '0.10.0'
  pod 'KeychainAccess', '3.1.2'
  pod 'web3swift', :git => 'git@github.com:214AlphaDev/web3swift.git', :commit => 'af07105a1f1d0c1b361950a793eee9dd34d04568'
  pod 'FlowKit', :git => 'git@github.com:214AlphaDev/flowkit.git', :branch => 'master'
  pod 'CommunityKit', :git => 'git@github.com:214AlphaDev/communitykitios.git', :branch => 'master'
end

target 'WalletKitTests' do
    use_frameworks!
    pod 'WalletKit', :path => '.'
end


target 'WalletKitDemo' do
    use_frameworks!
    pod 'WalletKit', :path => '.'
end

# Fix for PromiseKit uses Swift 5.0 version which is not yet supported by this project
post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['PromiseKit'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'
      end
    end
  end
end
