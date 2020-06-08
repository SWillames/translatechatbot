class InterpretService

    def self.call action, params
        case action
        when 'translate'
            TranslateBot::TranslateService.new(params).call()
        when 'help'
            HelpService.call()
        else
            'Não entendi o que você quer'
        end    
    end

end
