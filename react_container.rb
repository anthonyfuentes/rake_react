
module React
  class Container

    attr_reader :name, :component_name, :maps_dispatch, :maps_state

    def initialize(args = {})
      @component_name = args.fetch(:name, nil)
      @name = "#{component_name}Container"
      @maps_dispatch = args.fetch(:maps_dispatch, true)
      @maps_state = args.fetch(:maps_state, true)
    end

    def generate_scaffolding
      if component_name
        write_container
      else
        warn_missing_name
      end
    end

    private

    def write_container
      content = []
      content << imports
      content << map_state_declaration if maps_state
      content << map_dispatch_declaration if maps_dispatch
      content << connect_declaration
      content << export

      write_file(content)
    end

    def imports
      imports = ""
      imports += "import {connect} from 'react-redux'"
      imports += "\nimport {#{component_name}} from '../components'"
    end

    def map_state_declaration
      "const mapStateToProps = (state) => {\n"\
        "\tconst props = {\n\t\t//TODO\n\t}\n\n"\
        "\treturn props\n}"
    end

    def map_dispatch_declaration
      if maps_dispatch
        "const mapDispatchToProps = (dispatch) => {\n"\
          "\tconst props = {\n\t\t//TODO\n\t}\n\n"\
          "\treturn props\n}"
      end
    end

    def connect_declaration
      map_state_arg = arg_or_null("mapStateToProps", maps_state)
      map_dispatch_arg = arg_or_null("mapDispatchToProps", maps_dispatch)

      "const #{name} = connect(\n"\
        "\t#{map_state_arg},\n"\
        "\t#{map_dispatch_arg}\n"\
        ")(#{component_name})"
    end

    def arg_or_null(argument_name, condition)
      if condition
        argument_name
      else
        "null"
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

