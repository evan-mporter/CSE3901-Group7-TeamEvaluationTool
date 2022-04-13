class ApplicationController < ActionController::Base
  def root
    render html: "TODO!"
  end

  def login
  end

  def full_reset
  end

  def do_full_reset
    if params[:key] == '0c90301e-0b89-4840-b42b-0a86d3eef8d4'
      # https://stackoverflow.com/a/69955217
      Rails.application.eager_load! unless Rails.application.config.eager_load
      ApplicationRecord.descendants.each { |model| model.delete_all }

      flash[:success] = "Database dropped!"
      redirect_to root_url
    else
      flash.now[:danger] = 'Incorrect Key!'
      render :full_reset
    end
  end
end
