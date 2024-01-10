Pod::Spec.new do |spec|

  spec.name         = "YKRPC_POD_NAME"
  spec.version      = "0.0.1"
  spec.summary      = "YKRPC_POD_NAME 说明."
  spec.description      = <<-DESC
  YKRPC_POD_NAME long description of the pod here.
  DESC

  spec.homepage         = 'http://github.com/YKRPC_AUTHOR_NAME/YKRPC_POD_NAME'
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  spec.author             = { "YKRPC_AUTHOR_NAME" => "YKRPC_AUTHOR_EMAIL" }
  spec.ios.deployment_target = '9.0'

  spec.source       = { :git => "http://github/YKRPC_AUTHOR_NAME/YKRPC_POD_NAME.git", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source_files = 'YKRPC_POD_NAME/{Public,Private}/**/*.{h,m,mm,c,cpp,swift}'
  # spec.exclude_files = "YKRPC_POD_NAME/Exclude" #排除文件

  spec.project_header_files = 'YKRPC_POD_NAME/Private/**/*.{h}'
  spec.public_header_files = 'YKRPC_POD_NAME/Public/**/*.h' #此处放置组件的对外暴漏的头文件

  # ――― binary framework/lib ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #spec.vendored_frameworks = 'YKRPC_POD_NAME/Private/**/*.framework'
  #spec.vendored_libraries = 'YKRPC_POD_NAME/Private/**/*.a'

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  # 放置 json,font,jpg,png等资源
  #  spec.resources = ["YKRPC_POD_NAME/{Public,Private}/**/*.{xib}"]
  #  spec.resource_bundles = {
  #    'YKRPC_POD_NAME' => ['YKRPC_POD_NAME/Assets/*.xcassets', "YKRPC_POD_NAME/{Public,Private}/**/*.{png,jpg,font,json}"]
  #  }


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"
  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

  # 其他依赖pod
  # spec.dependency "XXXXXXXX"

#   spec.subspec 'WithLoad' do |ss|
#       ss.source_files = 'YKHawkeye/Src/MethodUseTime/**/*{.h,.m}'
#       ss.pod_target_xcconfig = {
#         'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) YKHawkeyeWithLoad'
#       }
#       ss.dependency 'YKHawkeye/Core'
#       ss.vendored_frameworks = 'YKHawkeye/Framework/*.framework'
#     end

end
