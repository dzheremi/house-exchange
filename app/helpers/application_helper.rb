module ApplicationHelper
  def show_errors(object)
    if object.errors.any?
      output =  '<div class="row">'
      output << '  <div class="col-md-12">'
      output << '    <h3>' + pluralize(object.errors.count, 'error') + ' are prevenging you from continuing:</h3>'
      output << '    <ul>'
      object.errors.full_messages.each do |msg|
        output << '      <li>' + msg + '</li>'
      end
      output << '    </ul>'
      output << '  </div>'
      output << '</div>'
      return output
    end
  end
end
