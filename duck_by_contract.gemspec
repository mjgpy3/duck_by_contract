Gem::Specification.new do |s|
  s.name = 'duck_by_contract'
  s.version = '0.0.1'
  s.licenses = ['MIT']
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ['Michael "Gilli" Gilliland']
  s.homepage = 'https://github.com/mjgpy3/duck_by_contract'
  s.date = '2014-08-22'
  s.summary = 'Duck-typed interfaces for Ruby!'
  s.description = 'Your wildest dreams have come true! Duck-typed interfaces in Ruby!'
  s.files = ['README.md']
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rake'
end
