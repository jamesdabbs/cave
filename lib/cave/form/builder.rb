require 'action_view'

class Cave::Form::Builder < ActionView::Helpers::FormBuilder
  def bootstrap2 control_type, field
    field = object.class.fields[field] if field.is_a?(Symbol)
    
    error = object.errors[field.name]
    value = object.lookup field.name

    if error.empty?
      error_class = error_html = ''
    else
      error_class = 'error'
      error_html  = "<span class='help-inline'>#{error.first}</span>"
    end

    label_html = label field.label, class: 'control-label'
    field_html = send control_type, field.name, value: value

    raw = %{
      #{label_html}
      <div class='controls'>
        #{field_html}
        #{error_html}
      </div>
    }.squish.html_safe

    @template.content_tag 'div', raw, class: "control-group #{field.name} #{error_class}"
  end

  
  def bootstrap control_type, field
    field = object.class.fields[field] if field.is_a?(Symbol)
    
    error = object.errors[field.name]
    value = object.lookup field.name

    if error.empty?
      error_class = error_html = ''
    else
      error_class = 'error'
      error_html  = "<span class='help-block'>#{error.first}</span>"
    end

    label_html = label field.label
    field_html = send control_type, field.name, value: value

    raw = %{
      #{label_html}
      <div class='form-group'>
        #{field_html}
        #{error_html}
      </div>
    }.squish.html_safe

    @template.content_tag 'div', raw, class: "form-control #{field.name} #{error_class}"
  end
end
