module Rain
  class TorrentOperationException < ::StandardError
  end

  module Adapter
    class TransmissionRpcAdapter
      def list
        Transmission.torrents.map do |t|
          {
            id: t.id,
            name: t.name,
            percent_done: t.percent_done,
            total_size: t.total_size,
            download_speed: t.download_speed
          }
        end
      end

      def add(url)
        result = Transmission::RPC::Torrent + url 
        if result == nil
          raise TorrentOperationException
        end
      end

      def remove(id)
        perform_on(id) { |t| t.delete! }
      end

      def start(id)
        perform_on(id) { |t| t.start! }
      end

      def stop(id)
        perform_on(id) { |t| t.stop! }
      end

      private

      def perform_on(id, &block)
        block.call(Transmission.torrents.find { |t| t.id == id })
      end
    end
  end
end
