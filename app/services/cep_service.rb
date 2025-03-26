class CepService
  include HTTParty
  base_uri 'https://viacep.com.br/ws'

  def self.buscar(cep)
    response = get("/#{cep}/json/")
    response.parsed_response
  rescue StandardError => e
    { erro: "Falha na consulta: #{e.message}" }
  end
end