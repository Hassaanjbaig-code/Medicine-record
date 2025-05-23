class SearchController < ApplicationController
  def index
    # search_field = params[:search].present? ? params[:search] : "*"

    # @doctor_register = DoctorRegister.search(search_field, fields: %i[First_name Last_name date_of_birth gender practicing_from specialization])

    # respond_to do | format |
    #   format.html { render :index }
    #   format.turbo_stream do
    #     render turbo_stream:
    #       turbo_stream.update("doctor_register",
    #         partial: "doctor_registers/showDoctor",
    #         locals: { doctor_register: @doctor_register })

    #   end
    # end
  end
end
