require 'rest-client'

module TranslateBot
    class TranslateService
        def initialize(params)
            @text = params["text"]
            @lang = params["lang"]
            @key = "trnsl.1.1.20200527T071651Z.274e2302ab11a94e.7c4dac2023bc229cd538fcc043e968280a95d5cf"
        end

        def call
            if @text == nil || @text == '' || @text == ' '
                return 'Informe algum texto para traduzir.'
            end
            if @lang == nil || @lang == '' || @lang == ' '
                return 'Informe o idioma.'
            end
            language = nil
            if @lang.upcase == "INGLES" || @lang.upcase == "INGLÊS" || @lang.upcase == "ING"
                language = "pt-en"
            elsif @lang.upcase == "PORTUGUES" || @lang.upcase == "PORTUGUÊS" || @lang.upcase == "PORTUGUES-BR" || @lang.upcase == "PORTUGUÊS-BR"
                language = "en-pt"
            end

            if language == nil 
                return 'Por favor entre com um idioma valido'
            end    
            @url = "https://translate.yandex.net/api/v1.5/tr.json/translate?key=#{@key}&lang=#{language}"
            res = RestClient.get(@url)
            val = JSON.parse(res.body)['text'][0].to_s

            response = "O termo #{@text} traduzido para #{lang} é: #{val}"

        end
    end    
end