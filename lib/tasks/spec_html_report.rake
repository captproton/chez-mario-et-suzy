require 'spec/rake/spectask'

# Taken from vendor/plugins/rspec_on_rails/tasks/rspec.rake
spec_prereq = File.exist?(File.join(RAILS_ROOT, 'config', 'database.yml')) ? "db:test:prepare" : :noop
task :noop do
end

namespace :spec do
  namespace :html do
    desc "Generate HTML report for specs"
    Spec::Rake::SpecTask.new(:report => spec_prereq) do |t|
      t.spec_files = FileList['spec/**/*_spec.rb']
      t.spec_opts = ["--format", "html:\"#{RAILS_ROOT}/doc/spec_report.html\""]
      t.fail_on_error = false
    end
  end
end
