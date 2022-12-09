ActiveAdmin.register Customer do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :first_name, :last_name, :building_apt_number, :street, :city, :province, :zip_code, :country, :email, :password

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs 'Customers' do
      f.input :first_name
      f.input :last_name
      f.input :building_apt_number
      f.input :street
      f.input :city
      f.input :province
      f.input :zip_code
      f.input :country, :as => :string
      f.input :email
      f.input :password
    end
    f.actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:first_name, :last_name, :building_apt_number, :street, :city, :province, :zip_code, :country, :email, :password]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
