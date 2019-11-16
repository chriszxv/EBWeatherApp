platform :ios, '11.0'

use_frameworks!

inhibit_all_warnings!

source 'https://github.com/CocoaPods/Specs.git'

workspace 'EBWeatherApp.xcworkspace'

target 'EBWeatherApp' do
	# Comment the next line if you don't want to use dynamic frameworks

	# Pods for EBWeatherApp
	pod 'R.swift', '= 5.1.0'
	pod 'RxAnimated', '= 0.6.1'
	pod 'RxCocoa', '= 5.0.1'
	pod 'RxSwift', '= 5.0.1'
	pod 'SnapKit', '= 5.0.1'
	pod 'SVProgressHUD', '= 2.2.5'

	target 'EBWeatherAppTests' do
		inherit! :search_paths
		# Pods for testing
	end

	target 'EBWeatherAppUITests' do
		inherit! :search_paths
		# Pods for testing
	end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'RxSwift'
            target.build_configurations.each do |config|
                if config.name == 'Debug'
                    config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
                end
            end
        end
    end
end
