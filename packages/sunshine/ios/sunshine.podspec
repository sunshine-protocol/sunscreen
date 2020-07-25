#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint sunshine.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'sunshine'
  s.version          = '0.0.1'
  s.summary          = 'Sunshine FFI Binding'
  s.description      = <<-DESC
Sunshine FFI Binding
                       DESC
  s.homepage         = 'https://sunshine.foundation'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Sunshine' => 'shekohex@gmail.com' }
  s.source           = { :path => '.' }
  s.public_header_files = 'Classes**/*.h'
  s.source_files = 'Classes/**/*'
  s.static_framework = true
  s.vendored_libraries = "**/*.a"
  s.dependency 'Flutter'
  s.frameworks = "IOKit", "CoreFoundation"
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
