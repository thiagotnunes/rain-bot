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

  it 'lists the available torrents' do
    client.stub(:list).and_return("this is the list")

    message.should_receive(:reply).with("this is the list")

    subject.list(message)
  end

  it 'adds a torrent' do
    client.stub(:add).with("url").and_return("added")

    message.should_receive(:reply).with("added")

    subject.add(message, "url")
  end

  it 'removes a torrent' do
    client.stub(:remove).with(3).and_return("removed")

    message.should_receive(:reply).with("removed")

    subject.remove(message, 3)
  end

  it 'starts a torrent' do
    client.stub(:start).with(3).and_return("started")

    message.should_receive(:reply).with("started")

    subject.start(message, 3)
  end

  it 'stops a torrent' do
    client.stub(:stop).with(3).and_return("stopped")

    message.should_receive(:reply).with("stopped")

    subject.stop(message, 3)
  end
end
