#
#  Be sure to run `pod spec lint NAME.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  
  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #
  
  spec.name         = "YKRPC_POD_NAME"
  spec.version      = "0.0.1"
  spec.summary      = "YKRPC_POD_NAME 说明."
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description      = <<-DESC
  YKRPC_POD_NAME long description of the pod here.
  DESC
  
  spec.homepage         = 'http://github.com/YKPRC_AUTHOR_NAME/YKRPC_POD_NAME'
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  
  
  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #
  
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  
  
  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #
  
  spec.author             = { "YKPRC_AUTHOR_NAME" => "YKPRC_AUTHOR_EMAIL" }
  # spec.social_media_url   = "https://twitter.com/YKPRC_AUTHOR_NAME"
  
  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #
  
  spec.ios.deployment_target = '9.0'
  
  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #
  
  spec.source       = { :git => "http://github/YKPRC_AUTHOR_NAME_EMAIL/YKRPC_POD_NAME.git", :tag => "#{spec.version}" }
  
  
  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #
  
  spec.source_files = 'YKRPC_POD_NAME/Classes/**/*.{h,m,mm,c,cpp,swift,pch}'
  # spec.exclude_files = "Classes/Exclude" #排除文件
  
  #spec.prefix_header_file = 'YKRPC_POD_NAME/Classes/YKRPC_POD_NAMEPrefixHeader.pch'
  
  spec.project_header_files = 'YKRPC_POD_NAME/Classes/Private/**/*.{h}'
  spec.public_header_files = 'YKRPC_POD_NAME/Classes/Public/**/*.h' #此处放置组件的对外暴漏的头文件
  
  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #
  
  # spec.resource  = "icon.png"
  # 放置 json,font,jpg,png等资源
  #  spec.resources = "YKRPC_POD_NAME/{Classes,Resources}/**/*.{png,jpg,font,json,xib}"
  
  #  spec.resource_bundles = {
  #     'YKRPC_POD_NAME' => ['YKRPC_POD_NAME/Assets/**/*.xcassets']
  #  }
  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"
  
  
  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #
  
  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"
  
  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"
  
  
  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.
  
  # spec.requires_arc = true
  
  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"
  
  # 组件化架构中间件
  # spec.dependency "YKModuleLifeCircleComponent"
  # spec.dependency "YKRouterComponent"
  # spec.dependency "YKModuleServiceComponent" # oc 服务中间件
  # spec.dependency "YKModuleServiceComponent.swift" #swift 服务中间件， 如果是纯oc组件，请注释此中间件
  
  # 其他依赖pod
end
