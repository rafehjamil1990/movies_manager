class ImportsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_movie, only: %i[show edit update destroy]

  def new
    @import = Import.new
  end

  def create
    @import = Import.new
    @import.import_class = import_params[:import_class]
    @import.save
    @import.csv.attach(import_params[:csv])

    @import.process_import

    redirect_to movies_path, notice: 'Imported Successfully'
  end

  private

  def import_params
    params.require(:import).permit(:import_class, :csv)
  end
end
