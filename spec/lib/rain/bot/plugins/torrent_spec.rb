require 'spec_helper'

describe Rain::Bot::Torrent do
  let(:client) { double("client") }
  let(:message) { message = double("message") }
  subject { Rain::Bot::Torrent.new(client) }

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
