
module React
  class Component

    attr_reader :name, :has_props, :is_stateful

    def initialize(args)
      @name = args.fetch(:name, nil)
      @has_props = args[:props] == 'f' ? false : true
      @is_stateful = args[:state] == 'f' ? false : true
    end

    def generate_scaffolding
      if name
        create_component
      else
        warn_missing_name
      end
    end

    private

    def create_component
      content = []
      content << imports
      content << component_declaration
      content << prop_types
      content << export
      write_file(content)
    end

    def imports
      if is_stateful
        "import React from 'react'"
      end
    end

    def component_declaration
      if is_stateful
        stateful_declaration
      else
        stateless_declaration
      end
    end

    def stateful_declaration
      "class #{name} extends React.Component {\n\n"\
        "#{render_declaration}\n"\
        "}"
    end

    def stateless_declaration
      "const #{name} = (props) => {\n\n"\
        "#{render_declaration}\n"\
        "}"
    end

    def render_declaration
      "  render() {\n"\
        "    // TODO\n"\
        "  }"
    end

    def prop_types
      if has_props
        "#{name}.propTypes = {\n"\
          "}"
      end
    end

    def export
      "export default #{name}"
    end

    def write_file(lines)
      directory = Dir.pwd
      File.open("#{directory}/#{name}.js", "w") do |file|
        write_lines(file, lines)
      end
    end

    def write_lines(file, lines)
      lines.each do |line|
        file.puts line
        file.puts
      end
    end

    def warn_missing_name
      puts "No name was specified, so a component file was not generated."
    end

  end
end

