module Babushka
  module DepRunnerHelpers
    def self.included base # :nodoc:
      base.send :include, HelperMethods
    end

    module HelperMethods
    end
  end

  class DepRunner
    include ShellHelpers
    include PromptHelpers
    include DefinerHelpers

    delegate :source_path, :to => :definer

    def initialize dep
      @dep = dep
    end

    def name
      @dep.name
    end
    def definer
      @dep.definer
    end
    def vars
      Base.task.vars
    end

    def set key, value
      define_var_accessors key unless respond_to? key
      send "#{key}=", value
    end
    def merge key, value
      set key, ((vars[key.to_s] || {})[:value] || {}).merge(value)
    end

    def var name, opts = {}
      define_var name, opts
      if vars[name.to_s].has_key? :value
        vars[name.to_s][:value]
      elsif opts[:ask] != false
        ask_for_var name.to_s
      end
    end

    def define_var_accessors key
      self.class.instance_eval {
        define_method key do
          vars[key.to_s][:value]
        end
        define_method "#{key}=" do |value|
          vars[key.to_s][:value] = value
        end
      }
    end

    def define_var name, opts = {}
      vars[name.to_s].update opts.dragnet(:default, :type)
    end

    def ask_for_var key
      printable_key = key.to_s.gsub '_', ' '
      set key, send("read_#{vars[key][:type] || 'value'}_from_prompt",
        "#{printable_key}#{" for #{name}" unless printable_key == name}",
        :default => default_for(key)
      )
    end

    def default_for key
      if Base.task.saved_vars[key.to_s][:value]
        Base.task.saved_vars[key.to_s][:value]
      elsif vars[key.to_s][:default].respond_to? :call
        instance_eval { vars[key.to_s][:default].call }
      elsif vars[key.to_s][:default].is_a? Symbol
        var vars[key.to_s][:default], :ask => false
      else
        vars[key.to_s][:default]
      end
    end

  end
end
