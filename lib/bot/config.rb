INTERPRETER_YAML_FILE = 'interpreters.yml'
ACTION_YAML_FILE      = 'actions.yml'

module Bot
  class Config
    attr_reader :connections, :actioneers, :interpreters, :actions

    def initialize
      @connections  = []
      @actioneers = []
      @interpreters = initialize_interpreters
      @actions      = initialize_actions
    end

    def setup
      @connections = @interpreters.map do |interpreter|
        interpreter.new
      end
      
      @actioneers = @actions.map do |action|
        action.new
      end
    end

    def initialize_actions
      Dir["./lib/actions/**/*.rb"].each {|f| require f}
      if File.readable?(ACTION_YAML_FILE)
        yaml = File.read(ACTION_YAML_FILE)
        load_yaml(yaml) do |data|
          data.map do |constant|
            Actions.const_get constant
          end
        end
      end
    end

    def initialize_interpreters
      Dir["./lib/interpreter/**/*.rb"].each {|f| require f}
      if File.readable?(INTERPRETER_YAML_FILE)
        yaml = File.read(INTERPRETER_YAML_FILE)
        load_yaml(yaml) do |data|
          data.map do |constant|
            Interpreter.const_get constant
          end
        end
      end
    end

    private
    
    def load_yaml(yaml)
      if loaded_yaml = YAML.load(yaml)
        raise "Invalid YAML type" unless loaded_yaml.is_a?(Array)
        yield loaded_yaml
      end
    end
  end
end
