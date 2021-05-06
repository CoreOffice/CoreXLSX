#
# Be sure to run `pod lib lint CoreXLSX.pod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CoreXLSX'
  s.version          = '0.14.1'
  s.summary          = 'Excel spreadsheet (XLSX) format support in pure Swift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.swift_versions    = ['5.1', '5.2']
  s.description      = <<-DESC
Excel spreadsheet (XLSX) format support in pure Swift.
DESC

  s.homepage         = 'https://github.com/CoreOffice/CoreXLSX'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE.md' }
  s.author           = { 'Max Desiatov' => 'max@desiatov.com' }
  s.source           = { :git => 'https://github.com/CoreOffice/CoreXLSX.git', :tag => s.version.to_s }

  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'

  s.source_files = 'Sources/CoreXLSX/**/*.swift'

  s.dependency 'ZIPFoundation', '~> 0.9.11'
  s.dependency 'XMLCoder', '~> 0.11.1'
end
