require 'will_paginate/view_helpers/action_view'

module WillPaginate
  module ActionView
    class BootstrapLinkRenderer < LinkRenderer
      def container_attributes
        { class: "pagination justify-content-center" }
      end

      def page_number(page)
        tag :li, link(page, page, rel: rel_value(page), class: 'page-link'), class: "page-item #{"active" if page == current_page}"
      end

      def gap
        tag :li, link(super, '#', class: 'page-link'), class: 'page-item disabled'
      end

      def previous_or_next_page(page, text, classname)
        tag :li, link(text, page || '#', class: 'page-link'), class: "page-item #{classname} #{"disabled" unless page}"
      end
    end
  end
end