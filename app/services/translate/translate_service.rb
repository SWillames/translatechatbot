require 'rest-client'
require './app/errors/errors.rb'

module TranslateBot
    class TranslateService
        def initialize(params)
            @text = params["text"]
            @source_lang = params["source_lang"]
            @target_lang = params["target_lang"]
            key = "trnsl.1.1.20200527T071651Z.274e2302ab11a94e.7c4dac2023bc229cd538fcc043e968280a95d5cf"
            @url = "https://translate.yandex.net/api/v1.5/tr.json/translate?key=#{key}&text=#{URI.encode_www_form_component(@text)}&lang=#{@source_lang}-#{@target_lang}"
        end

        def call
            message = "Falta algum dos parametros para tradução: 1- Texto a ser traduzido, 2- idioma de origem, 3- idioma final"
            
            response = JSON.parse(RestClient.post @url, {}, {'Accept' => '*/*', 'Content-Type' => 'application/x-www-form-urlencoded'})
            code = response['code']
            case code
                    when 400
                        return message
                    when 401, 402
                        raise Errors::ErrorComunication.new('Error when trying to communicate with API.')
                    when 413
                        raise Errors::ErrorTextLong.new("A text #{@text} exceed a 10.000 characters.")
                    when 200
                        return response['text'][0]
                    end        
            

        end
    end    
end