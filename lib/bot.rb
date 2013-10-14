require 'yaml'
require 'pry'

Interpreter = Module.new
Actions     = Module.new

module Bot
  extend self

  attr_reader :config, :buffers

  def config
    @config ||= Bot::Config.new
  end

  def start
    config.setup
    true
  end

  def run
    loop do
      run_once
    end
  end

  def run_once
    connections.each do |connection|
      data = connection.read
      buffers << {
        connection: connection,
        data: data
      } unless data.nil?
    end

    while buffer = buffers.shift
      actioneers.each do |actioneer|
        if matches = actioneer.matcher.match(buffer[:data])
          actioneer.action(matches, buffer[:connection])
        end
      end
    end
  end

  private

  def actioneers
    config.actioneers
  end

  def connections
    config.connections
  end

  def buffers
    @buffers ||= []
  end
end

require 'bot/config'

