require_relative './../spec_helper.rb'

describe 'HelpService' do
  describe '#call' do
    it 'Answer the following commands' do
        response = HelpService.call()
        expect(response).to match("Olá! Meu nome é Mariana e isso é o que posso fazer:")
        expect(response).to match("1 -> Traduzir 'X' em inglês para português")
        expect(response).to match("2 -> Como se fala 'Y' em inglês")
    end
  end
end