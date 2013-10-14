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
      output = connection.read
      buffer_push(connection, output)
    end

    buffers.flatten!

    while buffer = buffers.shift
      actioneers.each do |actioneer|
        if matches = actioneer.matcher.match(buffer[:data])
          actioneer.action(matches, buffer[:connection])
        end
      end
    end
  rescue => ex
    puts "Exception found: #{ex.message}\n#{ex.backtrace}"
  end

  def buffer_push(connection, data)
    buffers << {
      connection: connection,
      data: data
    } unless data.nil?
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

