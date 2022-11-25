class ContactPagesController < ApplicationController
  def show
    @contact_pages = ContactPage.all
  end
end
