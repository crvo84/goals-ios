platform :ios, '13.0'
use_frameworks!
workspace 'Goals'

# Dependencies
def rxPods
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
end

def rxTestPods
  pod 'RxBlocking', '~> 5'
  pod 'RxTest', '~> 5'
end

# ---------------
#   App project
# ---------------
target 'Goals' do
  rxPods
  pod 'Kingfisher', '~> 5.0'
  target 'GoalsTests' do
    rxTestPods
  end
end

# ---------------
# Shared projects
# ---------------
# VillouNetworking
target 'VillouNetworking' do
  project 'Shared/VillouNetworking/VillouNetworking'
  rxPods
  target 'VillouNetworkingTests' do
    rxTestPods
  end
end

#VillouSecurity
target 'VillouSecurity' do
  project 'Shared/VillouSecurity/VillouSecurity'
  target 'VillouSecurityTests' do
  end
end

# VillouImage
target 'VillouImage' do
    project 'Shared/VillouImage/VillouImage'
    pod 'Kingfisher', '~> 5.0'
    target 'VillouImageTests' do
    end
end
