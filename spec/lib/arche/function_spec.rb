require 'arche/type'

module Arche
  class Function < Type
    attr_reader :function

    def initialize(data={}, &block)
      super
      @function = block || Proc.new { nil }
    end

  end

  describe Function do
    it { should be_kind_of Arche::Type }

    it "has a Proc as its function" do
      subject.instance_eval("@function").should be_kind_of(Proc)
    end

    it "can be constructed with a Proc" do
      subject = Function.new { "fooBAR" }
      subject.instance_eval("@function.call").should == "fooBAR"
    end

    context "As an Arche::Type object" do
      it "has data members" do
        subject.foo = "FOO"
        subject[:foo].should == "FOO"
      end

      it "can be constructed with data members" do
        subject = Function.new({foo: "FOO"})
        subject.foo.should == "FOO"
      end
    end

    context "As a data member of an Arche::Type object" do
      subject { Type.new({ foo: "bar" }) }

      it "has access to its parent's data via 'this'" do
        subject.uppifier = Function.new do
          this.foo.upcase
        end
        subject.uppifier!.should == "BAR"
      end
    end
  end
end
