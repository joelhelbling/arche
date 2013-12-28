module Arche
  module Primitives
    def isNaN(thing)
      case thing
      when Fixnum
        false
      when Float
        false
      when String
        ! thing.match(/^[0-9]+$/)
      else
        true
      end
    end
  end
end


