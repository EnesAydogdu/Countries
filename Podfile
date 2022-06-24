# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'Countries' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'Kingfisher', '~> 7.0'
  # Pods for Countries

end

post_install do |installer|   
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end