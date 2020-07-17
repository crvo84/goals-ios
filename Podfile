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

# App project
target 'Goals' do
  rxPods
  target 'GoalsTests' do
    rxTestPods
  end
end

# Shared projects
sharedProjects = [
  'VillouNetworking',
  'VillouSecurity',
]
sharedProjects.each do |proj|
  target "#{proj}" do
    project "Shared/#{proj}/#{proj}"
    rxPods
    target "#{proj}Tests" do
      rxTestPods
    end
  end
end
