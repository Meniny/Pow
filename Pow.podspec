Pod::Spec.new do |s|
  s.name = 'Pow'
  s.version = '1.0.0'
  s.summary = 'A simple banner and pop-up displayer for iOS. Written in Swift.'
  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.requires_arc = true

  s.homepage         = 'https://github.com/Meniny/Pow'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'Elias Abel' => 'admin@meniny.cn' }
  s.source           = { :git => 'https://github.com/Meniny/Pow.git', :tag => s.version.to_s }

  s.frameworks = 'UIKit'
  s.dependency   'PapaLayout'

  s.default_subspecs = 'Core', 'Extra'

  s.subspec 'Core' do |sp|
    sp.source_files  = 'Pow/Core/**/*.swift'
  end

  s.subspec 'Extra' do |sp|
    sp.dependency      'Pow/Core'
    sp.source_files  = 'Pow/Extra/**/*.swift'
  end
end
