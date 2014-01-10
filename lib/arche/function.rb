module Arche
  class Function < Type
    attr_reader :function

    def initialize(data={}, &block)
      super
      @function = block || Proc.new { nil }
    end

  end
end
