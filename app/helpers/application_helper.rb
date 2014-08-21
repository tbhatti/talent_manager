module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render("/#{association.to_s}/" + association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')")
  end

  def link_to_remove_fields(name, f, add_new_params=nil)
    remove_method = "remove_fields(this);"
    remove_method << " #{function_for_add_fields(add_new_params[:f], add_new_params[:association], false, add_new_params[:css_class_name], add_new_params[:remove_delete_btn])}" if add_new_params.present?
    #f.hidden_field(:_destroy) + link_to_function(name, remove_method, :class => "badge close")
    f.hidden_field(:_destroy) + link_to_function(raw("<i class='icon-trash'></i>"), remove_method, :class => "btn btn-small")
  end
end
