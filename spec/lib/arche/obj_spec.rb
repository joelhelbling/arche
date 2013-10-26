require 'arche/type'

module Arche

  describe "Arche::Type" do
    context "Data members" do

      subject { Type.new({ foo: "FOO" }) }

      context "generally" do
        specify "can be accessed like a hash" do
          subject[:foo].should == "FOO"
        end

        specify "can be accessed with an accessor" do
          subject.foo.should == "FOO"
        end

        specify "can be added like a hash" do
          subject[:bar] = "BAR"
          subject.instance_eval("@data").should == { foo: "FOO", bar: "BAR" }
        end

        specify "can be added with an accessor" do
          subject.bar = "BAR"
          subject.instance_eval("@data").should == { foo: "FOO", bar: "BAR" }
        end
      end

      context "However, some characters are not allowed in ruby methods;" do
        specify "so, while anything can be a key," do
          key = Object.new
          subject[key] = "BAZ"
          subject.instance_eval("@data").should == { :foo => "FOO", key => "BAZ" }
        end

        specify "not everything can have accessors" do
          key = "ruby-doesnt-like-dashes"
          subject[key] = "very-much"
          subject.instance_eval("@data").should == { :foo => "FOO", "ruby-doesnt-like-dashes" => "very-much" }
          expect{ subject.ruby-doesnt-like-dashes }.to raise_error(NameError)
        end
      end

      context "Now, the use of an accessor also works if there is an equivelent string" do
        specify "for getters" do
          subject["could_be_symbol_but_actually_a_string"] = "Oh, that's nice"
          subject.instance_eval("@data").should == { :foo => "FOO", "could_be_symbol_but_actually_a_string" => "Oh, that's nice" }
          subject.could_be_symbol_but_actually_a_string.should == "Oh, that's nice"
        end

        specify "and for setters" do
          subject["could_be_symbol_but_actually_a_string"] = "original value"
          subject.could_be_symbol_but_actually_a_string = "new value"
          subject.instance_eval("@data").should == { :foo => "FOO", "could_be_symbol_but_actually_a_string" => "new value" }
        end
      end

      context "When both symbol and string versions exist," do
        subject { Type.new({:foo => "symbol", "foo" => "string" }) }

        specify "the getter accessor prefers the symbol version of the key" do
          subject.foo.should == "symbol"
        end

        specify "the setter accessor also prefers the symbol version of the key" do
          subject.foo = "CHANGED"
          subject.instance_eval("@data").should == { :foo => "CHANGED", "foo" => "string" }
        end
      end

    end
  end

end
