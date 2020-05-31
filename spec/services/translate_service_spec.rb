require_relative './../spec_helper.rb'
 
describe TranslateBot::TranslateService do
  before do
    @text = "Vaca"
    @lang = "ingles"
    @translate = "the cow"
  end
 
  describe '#call' do
    context "Without text param" do
      it "will receive a error" do
        @translateService = TranslateBot::TranslateService.new({"lang" => @lang})
        response = @translateService.call()
        expect(response).to match("Informe algum texto para traduzir.")
      end
    end

    context "Without lang param" do
      it "will receive a error" do
        @translateService = TranslateBot::TranslateService.new({"text" => @text})
        response = @translateService.call()
        expect(response).to match("Informe o idioma.")
      end
    end
 
    context "With Valid params" do
      before do
        @translateService = TranslateBot::TranslateService.new({"text" => @text, "lang" => @lang})
        @response = @translateService.call()
      end
 
      it "Receive success message" do
        expect(@response).to match("O termo #{@text} traduzido para #{@lang} é: #{@translate}")
      end

    end
  end
end