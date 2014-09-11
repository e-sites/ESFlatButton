Pod::Spec.new do |s|
  s.name           = "ESFlatButton"
  s.version        = "1.0.1"
  s.platform       = :ios, "6.0"
  s.summary        = "A beveled flat button"
  s.author         = { "Bas van Kuijck" => "bas@e-sites.nl" }
  s.license        = { :type => "BSD", :file => "LICENSE" }
  s.homepage       = "https://github.com/e-sites/ESFlatButton"
  s.source         = { :git => "https://github.com/e-sites/ESFlatButton.git", :tag => s.version.to_s }  
  s.source_files   = "Classes"
  s.requires_arc   = true
end