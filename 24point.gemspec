Gem::Specification.new do |s|  
  s.name        = '24point'  
  s.version     = '0.0.2'  
  s.date        = '2013-11-11'  
  s.summary     = "24-point game" 
  s.description = "A gem for 24-point calculate game"  
  s.authors     = ["Joy Hu"]  
  s.email       = 'joyhu8023danny@gmail.com'  
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.md"]
  s.license = 'MIT'
  candidates = %w(COPYING README.md Rakefile) +
    Dir.glob("{bin,doc/rdoc,spec,lib}/**/*") +
    Dir.glob("resources/**/*")
  s.files       =  candidates
  s.homepage    =  
    'https://github.com/huyong36/24point'
end  