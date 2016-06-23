require 'nokogiri'

module BuilderLinks
  class Analize
    def initialize(text, opts = {})
      @options = {black_uris: []}.merge(opts)
      @doc = Nokogiri::HTML(text)
      @analized_text = nil
      @total_links = 0
    end

    def run
      return @analized_text unless @analized_text.blank?

      BuilderLinks.patterns.each do |pattern|
        next if black_pattern?(pattern)

        links_per_pattern = 0
        @doc.search('p').children.each do |child|
          break if max_links_generated?(links_per_pattern)

          if analize_node(child, pattern)
            links_per_pattern += 1
            @total_links += 1
          end
        end
      end

      @analized_text = @doc.at('body').nil? ? '' : @doc.at('body').inner_html
    end

    def total_links
      @total_links
    end

    private
    def analize_node(node, pattern)
      if %('text', 'strong').include?(node.name) && node.children.count < 2
        replace_text = node.content

        prefix_suffix = pattern[:anchortext].include?(' ') ? '' : ' '
        result = replace_text.sub!(/(#{prefix_suffix}#{pattern[:anchortext]}#{prefix_suffix})/i,
                                   '<a href="' + pattern[:uri] + '" title="\1">\1</a>')

        unless result.nil?
          if node.name == 'text'
            node.replace replace_text
          else
            new_node = @doc.create_element node.name
            new_node.inner_html = replace_text
            node.replace new_node
          end

          return true
        end
      end

      false
    end

    def max_links_generated?(links_per_pattern)
      if !BuilderLinks.links_per_pattern.nil? && links_per_pattern >= BuilderLinks.links_per_pattern
        return true
      end
      if !BuilderLinks.total_links.nil? && @total_links >= BuilderLinks.total_links
        return true
      end

      false
    end

    def black_pattern?(pattern)
      @options[:black_uris].each do |black_uri|
        return true if black_uri.include?(pattern[:uri])
      end

      return false
    end
  end
end
