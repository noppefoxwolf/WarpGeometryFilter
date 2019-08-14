Pod::Spec.new do |s|
  s.name             = 'WarpGeometryFilter'
  s.version          = '0.1.0'
  s.summary          = 'A short description of WarpGeometryFilter.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/noppefoxwolf/WarpGeometryFilter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'noppefoxwolf' => 'noppelabs@gmail.com' }
  s.source           = { :git => 'https://github.com/noppefoxwolf/WarpGeometryFilter.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/noppefoxwolf'

  s.ios.deployment_target = '11.0'

  s.source_files = 'WarpGeometryFilter/Classes/**/*'
  s.swift_versions = ['5.0']
end
