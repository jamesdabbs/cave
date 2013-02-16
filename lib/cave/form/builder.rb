require 'action_view'

module Cave
  class Form
    class Builder < ActionView::Helpers::FormBuilder
      def bootstrap control_type, name
        label_html = label name, class: 'control-label'
        field_html = send control_type, name

        error = object.errors[name]
        if object.bound? && error
          error_class = 'error'
          error_html  = "<span class='help-inline'>#{error.first}</span>"
        else
          error_class = error_html = ''
        end

        raw = %{
          #{label_html}
          <div class='controls'>
            #{field_html}
            #{error_html}
          </div>
        }.squish.html_safe

        @template.content_tag 'div', raw, class: "control-group #{error_class}"
      end
    end
  end
end