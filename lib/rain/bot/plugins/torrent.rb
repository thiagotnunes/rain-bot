require 'cinch'

module Rain
  module Bot
    class Torrent
      include ::Cinch::Plugin

      match "list", method: :list
      def list(m)
        m.reply client.list
      end

      match /^add (.*)$/, method: :add
      def add(m, url)
        m.reply client.add url
      end

      private

      def client
        config[:client]
      end
    end
  end
end
