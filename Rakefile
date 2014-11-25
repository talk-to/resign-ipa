namespace "release" do
  desc "Create a remote tag for the current Gem version"
  task :tag do
    require 'rubygems'
    spec = Gem::Specification::load('resign-ipa.gemspec')
    tag = spec.version
    `git push origin master`
    `git tag #{tag}`
    `git push origin #{tag}`
  end
end
