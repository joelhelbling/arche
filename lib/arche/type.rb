module Arche
  class Type
    def initialize(data={})
      @data = data
    end

    def [](key)
      @data[key] # eventually we'll also check for key in the prototype
    end

    def []=(key, value)
      @data[key] = value
    end

    def method_missing(method_symbol, *arguments, &block)
      if function_call?(method_symbol)
        arche_function = @data[key_for_func(method_symbol)]
        if arche_function
          function = arche_function.function
          instance_exec(*arguments, &function)
        else
          raise TypeError.new("object is not a function")
        end
      elsif data_member? method_symbol
        self[method_symbol]
      elsif data_member? method_symbol.to_s
        self[method_symbol.to_s]
      # and eventually we'll also check for existance of key in the prototype...
      elsif setter? method_symbol
        self[key_for_setter(method_symbol)] = arguments.first
      else
        super.send method_symbol, *arguments, &block
      end
    end

    private

    def this
      self
    end

    def function_call?(method_symbol)
      method_symbol.to_s.match(/\!$/)
    end

    def data_member?(method_symbol)
      @data.keys.include?(method_symbol)
    end

    def setter?(method_symbol)
      method_symbol.to_s.match(/=$/)
    end

    def key_for_func(method_symbol)
      symbol_key = symbol_key_for_func(method_symbol)

      find_func_member symbol_key
    end

    def symbol_key_for_func(method_symbol)
      method_symbol.to_s.gsub(/\!$/, "").to_sym
    end

    def key_for_setter(method_symbol)
      symbol_key = symbol_key_for_setter(method_symbol)
      if only_string_version_exists? symbol_key
        symbol_key.to_s
      else
        symbol_key
      end
    end

    def symbol_key_for_setter(method_symbol)
      method_symbol.to_s.gsub(/=$/, "").to_sym
    end

    def only_string_version_exists?(symbol_key)
      data_member?(symbol_key.to_s) && ! data_member?(symbol_key)
    end

    def find_func_member(symbol_key)
      [symbol_key.to_sym, symbol_key.to_s].find do |key|
        data_member?(key) && @data[key].is_a?(Arche::Function)
      end
    end
  end

end
