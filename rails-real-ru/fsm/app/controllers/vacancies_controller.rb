# frozen_string_literal: true

class VacanciesController < ApplicationController
  before_action :get_vacancy, only: %i[archive publish]

  def index
    @on_moderate = Vacancy.on_moderate
    @published = Vacancy.published
  end

  def new
    @vacancy = Vacancy.new
  end

  def create
    @vacancy = Vacancy.new(vacancy_params)

    if @vacancy.save
      redirect_to vacancies_path, notice: 'Vacancy was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # BEGIN
  def archive
    @vacancy.archive!
    redirect_to vacancies_path, notice: 'Vacancy was successfully add to archive.'
  end

  def publish
    if @vacancy.may_publish?
      @vacancy.publish!
    end
    redirect_to vacancies_path, notice: 'Vacancy was successfully published.'
  end

  private

  def get_vacancy
    @vacancy = Vacancy.find(params[:id])
  end

  def vacancy_params
    params.require(:vacancy).permit(:title, :description)
  end
end
