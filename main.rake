working_dir = File.dirname(__FILE__)

load "#{working_dir}/react.rb"

namespace :react do

  desc "Generates basic React component template"
  task :comp, [:name, :props, :state] do |_, args|
    component = React::Component.new(args)
    component.generate_scaffolding
  end

  desc "Generates scaffolding for Redux-aware React component"
  task :cont, [:name, :maps_dispatch, :maps_state] do |_, args|
    args = Helper::Args::convert_boolean_args(args)

    container = React::Container.new(args)
    container.generate_scaffolding
  end

end
