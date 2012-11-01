require 'cinch'

module Rain
  module Bot
    class Torrent
      include ::Cinch::Plugin
      match "list", method: :list
      match /add (.*)/, method: :add
      match /remove \d+/, method: :remove
      match /start \d+/, method: :start
      match /stop \d+/, method: :stop

      def list(m)
        m.reply client.list
      end

      def add(m, url)
        m.reply client.add url
      end

      def remove(m, id)
        m.reply client.remove id
      end

      def start(m, id)
        m.reply client.start id
      end

      def stop(m, id)
        m.reply client.stop id
      end

      private

      def client
        config[:client]
      end
    end
  end
end
