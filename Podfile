platform :ios, '10.0'

def alamofire
  pod 'Alamofire', '~> 4.7'
  pod 'AlamofireObjectMapper', '~> 5.2'
  pod 'AlamofireImage', '~> 3.5'
end

target 'News' do
  use_frameworks!
	alamofire
    pod 'SnapKit', '~> 4.0.0'
    pod 'SVProgressHUD'

  target 'NewsTests' do
    inherit! :search_paths
	alamofire
  end

  target 'NewsUITests' do
    inherit! :search_paths
  end

end
