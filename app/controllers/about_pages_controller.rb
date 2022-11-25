class AboutPagesController < ApplicationController
  def show
    @about_pages = AboutPage.all
  end
end
