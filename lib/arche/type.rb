module Arche
  class Type
    def initialize(data={})
      @data = data
    end

    def [](key)
      @data[key]
    end

    def []=(key, value)
      @data[key] = value
    end

    def method_missing(method_symbol, *arguments, &block)
      if method_symbol.to_s =~ /\!$/ && @data.keys.include?(method_symbol.to_s.gsub(/\!$/, "").to_sym)
        function = @data[method_symbol.to_s.gsub(/\!$/, "").to_sym].function
        instance_eval(&function)
      elsif @data.keys.include? method_symbol
        self[method_symbol]
      elsif @data.keys.include? method_symbol.to_s
        self[method_symbol.to_s]
      elsif method_symbol.to_s =~ /=$/
        self[key_for_setter(method_symbol)] = arguments.first
      else
        super.send method_symbol, *arguments, &block
      end
    end

    private

    def this
      self
    end

    def key_for_setter(method_symbol)
      symbol_key = symbol_key_for_setter(method_symbol)
      only_string_version_exists?(symbol_key) ?
        symbol_key.to_s :
        symbol_key
    end

    def symbol_key_for_setter(method_symbol)
      method_symbol.to_s.gsub(/=$/, "").to_sym
    end

    def only_string_version_exists?(symbol_key)
      @data.keys.include?(symbol_key.to_s) && ! @data.keys.include?(symbol_key)
    end
  end

end
