class UfController < ApplicationController
  def index
    @uf_value = UfValue.find_by(date: Date.today)
  end

  def show
    begin
      search_date = Date.parse(params[:date])
      @uf_value = UfValue.find_by(date: search_date)

      if @uf_value.nil?
        flash.now[:alert] = "Valor de UF no encontrado para la fecha seleccionada."
      end
    rescue ArgumentError
      flash.now[:alert] = "Fecha inválida. Por favor, ingrese una fecha válida."
    end
    render :index
  end
end
