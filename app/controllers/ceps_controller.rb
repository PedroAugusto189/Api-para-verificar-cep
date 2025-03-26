class CepsController < ApplicationController
  def show
    cep = params[:id].gsub(/\D/, '') # Remove não-dígitos
    if cep.length == 8
      @resultado = Rails.cache.fetch("cep_#{cep}", expires_in: 1.day) do
        CepService.buscar(cep)
      end
    end

    respond_to do |format|
      format.html # Vai renderizar app/views/ceps/show.html.erb
      format.json do
        if cep.length == 8
          render json: @resultado
        else
          render json: { erro: "CEP deve ter 8 dígitos" }, status: :unprocessable_entity
        end
      end
    end
  end
end