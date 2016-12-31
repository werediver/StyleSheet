Pod::Spec.new do |s|
  s.name = "StyleSheet"
  s.version = "2.0.1"
  s.authors = { "Raman Fedaseyeu" => "werediver@gmail.com" }
  s.license = "MIT"
  s.homepage = "https://github.com/werediver/StyleSheet"
  s.source = { :git => "https://github.com/werediver/StyleSheet.git", :tag => "v#{s.version}" }
  s.summary = "Composable UI styles"
  s.ios.deployment_target = "8.0"
  s.source_files = "Sources/*.swift"
end
