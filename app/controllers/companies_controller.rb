# == Schema Information
#
# Table name: companies
#
#  id              :integer          not null, primary key
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  match_frequency :integer          default(168)
#

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

  def update
    company = set_company
    company.update(company_params)
    redirect_to admin_path(current_user)
  end

  private

    def company_params
      params.require(:company).permit(:name, :match_frequency, locations_attributes: [:name,:id])
    end

    def set_company
      Company.find(params[:id])
    end

end
