# frozen_string_literal: true

class BootstrapBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TextHelper

  delegate :content_tag, :tag, to: :@template

  def instructions(value)
    if value
      content_tag :div, class: 'form-text' do
        value
      end
    else
      ''
    end
  end

  %w[text_field text_area password_field number_field email_field file_field telephone_field email_field].each do |method_name|
    define_method(method_name) do |name, *args|
      options = args.extract_options!
      has_label = (options[:has_label] == false) ? false : true
      required = object.errors[name].any?
      required_css = required ? 'has-error' : ''
      instructions = options[:instructions]

      options[:class] = "form-control #{options[:class]} #{required_css}"
      if has_label
        content_tag :div, class: "mb-3 #{options[:wrapping_class]} #{required_css}" do
          if options[:wrapping_class] == 'form-floating'
            super(name, options) + field_label(name) + instructions(instructions) + display_error(name, object.errors)
          else
            field_label(name) + super(name, options) + instructions(instructions) + display_error(name, object.errors)
          end
        end
      else
        super(name, options) + display_error(name, object.errors)
      end
    end
  end

  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    required = object.errors[method].any?
    required_css = required ? "has-error" : ""
    html_options[:class] = "form-control #{html_options[:class]}"
    has_label = (html_options[:has_label] == false) ? false : true
    if has_label
      content_tag :div, class: "mb-3 #{required_css}" do
        field_label(method) + super(method, collection, value_method, text_method, options, html_options) + display_error(method, object.errors)
      end
    else
      super(method, collection, value_method, text_method, options, html_options) + display_error(method, object.errors)
    end
  end

  def select(method, choices, options = {}, html_options = {})
    required = object.errors[method].any?
    required_css = required ? 'has-error' : ''
    html_options[:class] = 'form-control'
    content_tag :div, class: "mb-3 #{required_css}" do
      field_label(method) + super(method, choices, options, html_options)
    end
  end

  def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
    text ||= object.class.human_attribute_name(method)
    content_tag :div, class: 'checkbox mb-3' do
      label(method) do
        super(method, options, checked_value, unchecked_value) + ' ' + text
      end
    end
  end

  def form_actions(cancel_route)
    content_tag :div, class: 'mb-3' do
      content_tag(:hr) + button(:submit, class: 'btn btn-primary') + link_to('Cancel', cancel_route, class: 'btn btn-default')
    end
  end

  def form_submit(btn_text="Save")
    content_tag(:div, class: 'mb-3') do
      button(:submit, class: 'btn btn-primary') do
        btn_text
      end
    end
  end

  def error_messages
    if object.errors.full_messages.any?
      content_tag(:div, class: 'alert alert-danger padded-alert') do
        content_tag(:h2, "#{pluralize(object.errors.count, 'error')} prohibited this test from being saved:") +
        content_tag(:ul) do
          object.errors.full_messages.map do |msg|
            content_tag(:li, msg)
          end.join.html_safe
        end
      end
    end
  end

  private

    def display_error(key, errors)
      content_tag(:div, errors[key].first, class: 'form-text') if errors[key].any?
    end

    def field_label(name, *args)
      options = args.extract_options!
      label(name, options[:label], class: 'form-label')
    end
end
