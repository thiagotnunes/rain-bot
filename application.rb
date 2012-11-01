require 'yaml'
require_relative 'lib/rain'

adapter = Rain::Adapter::TransmissionRpcAdapter.new
client = Rain::Client.new(adapter)
config = YAML.load_file("configuration.yml")

bot = Cinch::Bot.new do
  configure do |c|
    c.server = config["irc"]["server"]
    c.nick = config["irc"]["nick"]
    c.password = config["irc"]["password"]
    c.channels = [config["irc"]["channel"]]

    c.plugins.plugins = [Rain::Bot::Torrent]
    c.plugins.options[Rain::Bot::Torrent][:client] = client
  end
end

bot.start
