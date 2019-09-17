

Pod::Spec.new do |s|
  s.name         = "LTIndicatorView" # 项目名称
  s.version      = "0.0.6"        # 版本号 与 你仓库的 标签号 对应
  s.license      = { :type => "MIT", :file => "LICENSE" }          # 开源证书
  s.summary      = "自定义指示器" # 项目简介
  s.homepage     = "https://github.com/ls19491314/LTIndicatorView" # 仓库的主页
  s.source       = { :git => "https://github.com/ls19491314/LTIndicatorView.git", :tag => "#{s.version}" }#你的仓库地址，不能用SSH地址
  #s.source_files = 'Classes/Main/*.{swift}','Classes/Main/**/*.{swift,h,m}'
  s.requires_arc = true # 是否启用ARC
  s.author       = { "Guess" => "abc@xyz.com" } # 作者信息
  s.platform     = :ios, "8.0" #平台及支持的最低版本
  s.frameworks   = "UIKit" #支持的框架

  s.default_subspec = 'core'

  s.subspec 'core' do |c|
  c.source_files  = 'Classes/*.{swift,h,m}'
  end

end
# pod lib lint --allow-warnings
# pod trunk push LTIndicatorView.podspec --allow-warnings