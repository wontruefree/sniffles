module Sniffles
  module Sniffers
    class Joomla
      include HTML

      attr_accessor :doc
      attr_reader :output

      def initialize(response_body)
        @output = {}
        parse(response_body) && process_document
      end

      def process_document
        if @output[:found] = found?
          parse_version
        end
      end

      private
      def found?
        !!(meta_generator_content =~ /Joomla!/)
      end

      def parse_version
        @output[:version] = (meta_generator_content =~ /Joomla! ([\d]+\.[\d]+)/ ? $1 : false)
      end

      def meta_generator_content
        text_at("//meta[@name='generator']/@content")
      end
    end
  end
end
