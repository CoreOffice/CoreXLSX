#
# Be sure to run `pod lib lint CoreXLSX.pod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CoreXLSX'
  s.version          = '0.1.0'
  s.summary          = 'XLSX (Excel spreadsheet) format suppport written in Pure Swift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.swift_version    = '4.2'
  s.description      = <<-DESC
XLSX (Excel spreadsheet) format suppport written in Pure Swift.
                       DESC

  s.homepage         = 'https://github.com/MaxDesiatov/CoreXLSX'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE.md' }
  s.author           = { 'Max Desiatov' => 'max@desiatov.com' }
  s.source           = { :git => 'https://github.com/MaxDesiatov/CoreXLSX.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/MaxDesiatov'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Sources/CoreXLSX/**/*.swift'
  
  # s.resource_bundles = {
  #   'CoreXLSX.pod' => ['CoreXLSX.pod/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'ZIPFoundation', '~> 0.9'
  s.dependency 'XMLCoder', '~> 0.1'
end
