Pod::Spec.new do |s|
  s.name         = "TAutoArchiver"
  s.version      = "1.0.2"

  s.summary      = "归档KeyedArchiver, 以及auto NSCoding"
  
  s.homepage     = "https://github.com/Fmyz/TAutoArchiver"
  s.license      = "MIT"
  s.author       = { "Fmyz" => "https://github.com/Fmyz/TAutoArchiver" }

  s.platform     = :ios,'7.0'
  s.source       = { :git => "https://github.com/Fmyz/TAutoArchiver.git", :tag => "#{s.version}" }

  s.source_files = "TClasses/*.{h,m}"

  s.requires_arc = true

end
