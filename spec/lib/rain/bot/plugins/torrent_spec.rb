require 'spec_helper'

describe Rain::Bot::Torrent do
  let(:client) { double("client") }
  let(:message) { message = double("message") }

  subject do 
    # FIXME: Workaround here to set the client, this is really ugly damn!
    the_client = client
    bot = ::Cinch::Bot.new do
      configure do |c|
        c.plugins.options[Rain::Bot::Torrent][:client] = the_client
      end
    end
    Rain::Bot::Torrent.new(bot) 
  end

  it 'should list the available torrents' do
    client.stub(:list).and_return("this is the list")

    message.should_receive(:reply).with("this is the list")

    subject.list(message)
  end

  it 'should add a torrent' do
    client.stub(:add).with("url").and_return("added successfully")

    message.should_receive(:reply).with("added successfully")

    subject.add(message, "url")
  end
end
