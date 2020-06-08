require_relative './../spec_helper.rb'
require "./app/errors/errors.rb"
 
describe TranslateBot::TranslateService do
   
  describe '#call' do
    let(:text) {FFaker::Lorem.word}
    let(:text_translated) {FFaker::Lorem.word}
    let(:source_lang) { FFaker::Locale.language('random')}
    let(:target_lang) {FFaker::Locale.language('random')}
    
    context "Error translating" do
       
        context "Bad Request" do

          let(:response_of_api)do
            {
              code: 400,
              message: 'Error'
            }
          end
          before do
            allow(RestClient).to receive(:post) { response_of_api.to_json }
          end
             
            context "Without some param" do
              it "will receive a error" do
                @translateService = TranslateBot::TranslateService.new({"text" => text, "source_lang" => source_lang})
                response = @translateService.call()
                format_translat = "1- Texto a ser traduzido, 2- idioma de origem, 3- idioma final"
                expect(response).to match("Falta algum dos parametros para tradução: #{format_translat}")
              end
            end
        end

        context "Internal error" do
            
                let(:response_of_api)do
                    {
                        code: rand(401..402),
                        message: 'Error'
                    }
                end

                before do
                    allow(RestClient).to receive(:post) { response_of_api.to_json }
                end

                it "Error of comunicate" do
                    message = 'Error when trying to communicate with API.'
                    expect{ 
                        TranslateBot::TranslateService.new({
                            'text' => text, 
                            'source_lang' => source_lang, 
                            'target_lang' => target_lang}).call()
                    }.to raise_error(Errors::ErrorComunication, message)
                end
        end

        context "Text too long" do
                
                let(:text_long) {FFaker::Lorem.characters(character_count = 10001)}
                let(:response_of_api)do
                    {
                        code: 413,
                        message: 'Text error too long.'
                    }
                end

                before do
                    allow(RestClient).to receive(:post) {response_of_api.to_json}
                end

                it "raise a ApiTextMaxSizeError" do
                    message = "A text #{text_long} exceed a 10.000 characters."
                    expect{ 
                        TranslateBot::TranslateService.new({
                            'text' => text_long, 
                            'source_lang' => source_lang, 
                            'target_lang' => target_lang}).call() 
                    }.to raise_error(Errors::ErrorTextLong, message)
                end
        end    
    end

    context "Success" do
      
      let(:response_of_api)do
        {
          code: 200,
          lang: "#{source_lang}-#{target_lang}",
          text: [
              text_translated
          ]
        }
      end

        before do
          allow(RestClient).to receive(:post) {response_of_api.to_json}
          @response = TranslateBot::TranslateService.new({
                      'text' => text, 
                      'source_lang'=> source_lang, 
                      'target_lang' => target_lang}).call()
        end

        it "will receive a translated text" do
             expect(@response).to match("#{text_translated}")
        end

      end

    end
  end
