module BuilderLinks
  class Analize
    def initialize(text)
      @doc = Nokogiri::HTML(text)
      @analized_text = nil
    end

    def run
      return @analized_text unless @analized_text.blank?

      total_links = 0
      BuilderLinks.patterns.each do |pattern|
        keyword_links = 0
        @doc.search('p').children.each do |child|
          break if max_links_generated?(total_links, keyword_links)

          if analize_node(child, pattern)
            keyword_links += 1
            total_links += 1
          end
        end
      end

      @analized_text = @doc.at('body').nil? ? '' : @doc.at('body').inner_html
    end

    private

    def analize_node(node, pattern)
      if %('text', 'strong').include?(node.name) && node.children.count < 2
        replace_text = node.content

        prefix_suffix = pattern[:keyword].include?(' ') ? '' : ' '
        result = replace_text.sub!(/(#{prefix_suffix}#{pattern[:keyword]}#{prefix_suffix})/i,
                                   '<a href="' + pattern[:link] + '" title="\1">\1</a>')

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

    def max_links_generated?(total_links, keyword_links)
      if !BuilderLinks.keyword_links.nil? && keyword_links >= BuilderLinks.keyword_links
        return true
      end
      if !BuilderLinks.total_links.nil? && total_links >= BuilderLinks.total_links
        return true
      end

      false
    end
  end
end
