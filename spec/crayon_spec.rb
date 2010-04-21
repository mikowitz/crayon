require File.expand_path(File.dirname(__FILE__) + "/helper")

def test_parse_method_name(input, *output)
  it "should return #{output.inspect} for :#{input}" do
    Crayon.parse_method_name(input).should == output
  end
end

def test_prepare_string(expected_output, *args)
  it "should return correctly for #{args.inspect}" do
    Crayon.prepare_string(*args).should == expected_output
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
  describe "method_missing" do
    before do
      Crayon.should_receive(:prepare_string).with("hello", "red", nil, [])
    end
    it "should work" do
      Crayon.red("hello")
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
