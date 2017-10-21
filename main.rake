working_dir = File.dirname(__FILE__)

load "#{working_dir}/react.rb"

namespace :react do

  desc "Generates basic React component template"
  task :comp, [:name, :props, :state] do |_, args|
    component = React::Component.new(args)
    component.generate_scaffolding
  end

end
