require File.expand_path(File.dirname(__FILE__) + "/helper")

def test_parse_method_name(input, *output)
  describe "for input :#{input}" do
    before do
      Crayon.method_name = input
      Crayon.parse_method_name
      @fore, @back, @form = output
    end
    after { [:foreground, :background, :formatting].each {|method| Crayon.send(:"#{method}=", nil) } }
    it "should return #{@fore.inspect} for foreground" do
      Crayon.foreground.should == @fore
    end
    it "should return #{@back.inspect} for background" do
      Crayon.background.should == @back
    end
    it "should return #{@form.inspect} for formatting" do
      Crayon.formatting.should == @form
    end
  end
end

def test_prepare_string(expected_output, *args)
  it "should return correctly for #{args.inspect}" do
    Crayon.foreground = args.fetch(1) { nil }
    Crayon.background = args.fetch(2) { nil }
    Crayon.formatting = args.fetch(3) { []  }
    Crayon.prepare_string(args.first).should == expected_output
  end
end

describe "Crayon" do
  it "should, by default, add line breaks" do
    Crayon.newline?.should be
  end
  describe "after a print command" do
    before { Crayon.print }
    it "should not add line breaks" do
      Crayon.newline?.should_not be
    end
  end
  describe "after a puts command" do
    before { Crayon.puts }
    it "should add line breaks" do
      Crayon.newline?.should be
    end
  end
  it "chaining color calls should be allowed by return Crayon from method_missing" do
    Crayon.red("OK").should == Crayon
  end
  describe "method_missing" do
    describe "should call :prepare string" do
      before { Crayon.should_receive(:prepare_string).with("hello") }
      it "when Crayon.red is called" do
        Crayon.red("hello")
      end
    end
    describe "should unset instance variables after being called" do
      before { Crayon.bold_red_on_green("hello") }
      it "should unset foreground" do
        Crayon.foreground.should be_nil
      end
      it "should unset background" do
        Crayon.background.should be_nil
      end
      it "should unset formatting" do
        Crayon.formatting.should be_empty
      end
      it "should unset method_name" do
        Crayon.method_name.should be_nil
      end
    end
  end
  describe "parse_method_name" do
    test_parse_method_name(:red, "red", nil, [])
    test_parse_method_name(:on_red, nil, "red", [])
    test_parse_method_name(:bold, nil, nil, ["bold"])

    test_parse_method_name(:blue_on_green, "blue", "green", [])
    test_parse_method_name(:bold_cyan_on_magenta, "cyan", "magenta", ["bold"])

    test_parse_method_name(:red_green, "red", nil, [])
    test_parse_method_name(:red_bold_underline, "red", nil, ["bold", "underline"])
    test_parse_method_name(:underline_on_green_bold, nil, "green", ["underline", "bold"])

    describe "with invalid input" do
      test_parse_method_name(:notacolor, nil, nil, [])
      test_parse_method_name(:on_notacolor, nil, nil, [])
      test_parse_method_name(:blue_on_notacolor, "blue", nil, [])
    end
  end

  describe "prepare_string" do
    describe "with no line break" do
      before { Crayon.print }
      test_prepare_string("hello", "hello") 
      test_prepare_string("\e[31mhello\e[0m", "hello", "red", nil)
      test_prepare_string("\e[33m\e[47mhello\e[0m", "hello", "yellow", "white")
      test_prepare_string("\e[4m\e[1mhello\e[0m", "hello", nil, nil, ["underline", "bold"])
    end

    describe "with a line break" do
      before { Crayon.puts }
      test_prepare_string("hello\n", "hello") 
      test_prepare_string("\e[31mhello\e[0m\n", "hello", "red", nil)
      test_prepare_string("\e[33m\e[47mhello\e[0m\n", "hello", "yellow", "white")
      test_prepare_string("\e[4m\e[1mhello\e[0m\n", "hello", nil, nil, ["underline", "bold"])
    end
  end
end
