Pod::Spec.new do |s|
   s.name     = 'PEAR-AutoLayout-iOS'
   s.version  = '0.0.3'
   s.platform = :'ios', '7.0'
   s.license  = 'MIT'
   s.summary  = 'auto layout library for ios'
   s.homepage = 'https://github.com/HirokiUmatani/PEAR-AutoLayout-iOS'
   s.author   = { "HirokiUmatani" => "info@pear.chat" }
   s.source   = { :git => 'https://github.com/HirokiUmatani/PEAR-AutoLayout-iOS.git', :tag => s.version.to_s }
   s.source_files = 'PEAR-AutoLayout-iOS/*.{h,m}'
   s.requires_arc = true
end
