class CompaniesController < ApplicationController

  def show
    @company = set_company
  end

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
    @location = @company.locations.build
  end

  def create
    # binding.pry
    @company = Company.new(company_params)
    if @company.save
      render @company
    else
      render 'new'
    end
  end

  def edit
    @company = set_company
  end

  # def update
  #   @company = set_company
  #   if @company.save
  #     render @company
  #   else
  #     render edit_company_path(@company)
  #   end
  # end

  private

  def company_params
    params.require(:company).permit(:name, locations_attributes: [:name])
  end

  def set_company
    Company.find(params[:id])
  end
end
