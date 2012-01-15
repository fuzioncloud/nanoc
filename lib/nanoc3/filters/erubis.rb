# encoding: utf-8

require 'erubis'

module Nanoc3::Filters
  class Erubis < Nanoc3::Filter

    # The same as `::Erubis::Eruby` but adds `_erbout` as an alias for the
    # `_buf` variable, making it compatible with nanoc’s helpers that rely
    # on `_erbout`, such as {Nanoc3::Helpers::Capturing}.
    class ErubisWithErbout < ::Erubis::Eruby
      include ::Erubis::ErboutEnhancer
    end

    # Runs the content through [Erubis](http://www.kuwata-lab.com/erubis/).
    # This method takes no options.
    #
    # @param [String] content The content to filter
    #
    # @return [String] The filtered content
    def run(content, params={})
      # Create context
      context = ::Nanoc3::Context.new(assigns)

      # Get binding
      proc = assigns[:content] ? lambda { assigns[:content] } : nil
      assigns_binding = context.get_binding(&proc)

      # Get result
      ErubisWithErbout.new(content, :filename => filename).result(assigns_binding)
    end

  end
end
