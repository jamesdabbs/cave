require 'action_view'

class Cave::Form::Builder < ActionView::Helpers::FormBuilder
  def bootstrap control_type, name
    error = object.errors[name]
    if object.bound?
      value = object.send name
      unless error.empty?
        error_class = 'error'
        error_html  = "<span class='help-inline'>#{error.first}</span>"
      end
    else
      value = error_class = error_html = ''
    end

    label_html = label name, class: 'control-label'
    field_html = send control_type, name, value: value

    raw = %{
      #{label_html}
      <div class='controls'>
        #{field_html}
        #{error_html}
      </div>
    }.squish.html_safe

    @template.content_tag 'div', raw, class: "control-group #{name} #{error_class}"
  end
end

module ActionView::Helpers::FormHelper
  def form_for record, options={}, &proc
    if record.is_a? Cave::Form
      options[:builder] ||= Cave::Form::Builder
    end
    super record, options, &proc
  end
end