Pod::Spec.new do |s|
  s.name             = 'OutpanAPI'
  s.module_name      = 'OutpanAPI'
  s.version          = '1.1'
  s.license          = 'MIT'
  s.summary          = 'Outpan API wrapper written in Swift'
  s.homepage         = 'https://github.com/Rehsco/OutpanAPI.git'
  s.authors          = { 'Martin Jacob Rehder' => 'gitrepocon01@rehsco.com' }
  s.source           = { :git => 'https://github.com/Rehsco/OutpanAPI.git', :tag => s.version }

  s.ios.deployment_target = '10.0'

  s.framework    = 'AVFoundation'
  s.source_files = 'OutpanAPI/*.swift'
  s.requires_arc = true
end
