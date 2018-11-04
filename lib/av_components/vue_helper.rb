module AvComponents
  module VueHelper
    def vcomponent(name, attributes = {}, &block)
      AvComponents::VueHelper.vcomponent_stack = name.gsub('-', '/')
      if block_given?
        "<#{name} " + attributes.map{ |k, v| "#{k}=\"#{v}\"" }.join(" ") + ">#{capture(&block)}</#{name}>"
      else
        "<#{name} " + attributes.map{ |k, v| "#{k}=\"#{v}\"" }.join(" ") + "></#{name}>"
      end
    end

    def vtemplate(&block)
      if block_given?
        "<script id=\"#{vname(caller[0])}\" type=\"javascript/x-template\">#{capture(&block)}</script>"
      else
        "<script id=\"#{vname(caller[0])}\" type=\"javascript/x-template\"></script>"
      end
    end

    def vname(file)
      cnames = file.split(/^.*\/views\/(.*)\.html\.slim.*$/).reject(&:blank?).first.split("/")
      partial_name = cnames.pop
      if partial_name[0] == "_"
        partial_name[0] = ''
      end
      cnames << partial_name

      "v-template-#{cnames.join('-')}"
    end

    def self.vcomponent_stack
      RequestStore.store[:vcomponent_stack] ||= []
    end

    def self.pop_vcomponent_stack
      return if RequestStore.store[:vcomponent_stack].blank?

      RequestStore.store[:vcomponent_stack_rendered] = [] if RequestStore.store[:vcomponent_stack_rendered].blank?

      RequestStore.store[:vcomponent_stack].each do |component|
        if RequestStore.store[:vcomponent_stack_rendered].include?(component)
          next
        end

        yield(component)

        RequestStore.store[:vcomponent_stack_rendered] << component
      end
    end

    def pop_vcomponent_stack(&block)
      AvComponents::VueHelper.pop_vcomponent_stack(&block)
    end

    def self.vcomponent_stack=(value)
      if RequestStore.store[:vcomponent_stack].nil?
        RequestStore.store[:vcomponent_stack] = [value]
      else
        RequestStore.store[:vcomponent_stack] << value
      end
      RequestStore.store[:vcomponent_stack] = RequestStore.store[:vcomponent_stack].uniq
    end
  end
end
