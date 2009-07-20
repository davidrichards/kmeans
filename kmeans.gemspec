# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{kmeans}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Richards"]
  s.date = %q{2009-07-20}
  s.default_executable = %q{kmeans}
  s.description = %q{A simple KMeans algorithm}
  s.email = %q{davidlamontrichards@gmail.com}
  s.executables = ["kmeans"]
  s.files = ["README.rdoc", "VERSION.yml", "bin/kmeans", "lib/ext", "lib/ext/enumerable.rb", "lib/ext/object.rb", "lib/include_kmeans.rb", "lib/kmeans", "lib/kmeans/agent.rb", "lib/kmeans/centroid.rb", "lib/kmeans/node.rb", "lib/kmeans.rb", "spec/ext", "spec/ext/enumerable_spec.rb", "spec/ext/object_spec.rb", "spec/kmeans", "spec/kmeans/agent_spec.rb", "spec/kmeans/centroid_spec.rb", "spec/kmeans/node_spec.rb", "spec/kmeans_spec.rb", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/davidrichards/kmeans}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{KMeans for clustering}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<davidrichards-tegu_gears>, [">= 0"])
    else
      s.add_dependency(%q<davidrichards-tegu_gears>, [">= 0"])
    end
  else
    s.add_dependency(%q<davidrichards-tegu_gears>, [">= 0"])
  end
end
