require "spec_helper"

def test_parse_method_name(input, *output)
  describe "for input :#{input}" do
    before do
      Crayon.method_name = input
      Crayon.parse_method_name
      @fore, @back, @form = output
    end
    after { [:foreground, :background, :formatting].each {|method| Crayon.send(:"#{method}=", nil) } }
    it "should return #{@fore.inspect} for foreground" do
      expect(Crayon.foreground).to eq @fore
    end
    it "should return #{@back.inspect} for background" do
      expect(Crayon.background).to eq @back
    end
    it "should return #{@form.inspect} for formatting" do
      expect(Crayon.formatting).to eq @form
    end
  end
end

def test_prepare_string(expected_output, *args)
  it "should return correctly for #{args.inspect}" do
    Crayon.foreground = args.fetch(1) { nil }
    Crayon.background = args.fetch(2) { nil }
    Crayon.formatting = args.fetch(3) { []  }
    expect(Crayon.prepare_string(args.first)).to eq expected_output
  end
end

describe "Crayon" do
  describe "chaining color calls" do
    it "should be allowed by returning a CrayonString from method_missing" do
      expect(Crayon.red("OK")).to be_a CrayonString
    end
    it "should return the full chained string" do
      expect(Crayon.red("OK").blue("OK").underline("OK")).to eq "\e[31mOK\e[0m\e[34mOK\e[0m\e[4mOK\e[0m"
    end
  end
  describe "method_missing" do
    describe "should call :prepare string" do
      before { expect(Crayon).to receive(:prepare_string).with("hello") }
      it "when Crayon.red is called" do
        Crayon.red("hello")
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
    
    describe "with mixed-case input" do
      test_parse_method_name(:RED, "red", nil, [])
      test_parse_method_name(:ON_red, nil, "red", [])
      test_parse_method_name(:bOld, nil, nil, ["bold"])

      test_parse_method_name(:BlUe_on_GREEN, "blue", "green", [])
      test_parse_method_name(:UNDERline_oN_Green_BOLD, nil, "green", ["underline", "bold"])
    end

    describe "with invalid input" do
      test_parse_method_name(:notacolor, nil, nil, [])
      test_parse_method_name(:on_notacolor, nil, nil, [])
      test_parse_method_name(:blue_on_notacolor, "blue", nil, [])
    end
  end

  describe "prepare_string" do
    test_prepare_string("hello", "hello")
    test_prepare_string("\e[31mhello\e[0m", "hello", "red", nil)
    test_prepare_string("\e[33m\e[47mhello\e[0m", "hello", "yellow", "white")
    test_prepare_string("\e[4m\e[1mhello\e[0m", "hello", nil, nil, ["underline", "bold"])
  end
end
