class HelpService
    def self.call
        welcome = "Olá! Meu nome é Mariana e isso é o que posso fazer:\n"
        pharse1 = "1 -> Traduzir 'X' em inglês para português\n"
        pharse2 = "2 -> Como se fala 'Y' em inglês."

        "#{welcome} #{pharse1} #{pharse2}"
    end
end