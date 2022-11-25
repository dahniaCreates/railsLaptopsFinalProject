require "uri"
require "csv"

Product.destroy_all
Category.destroy_all
Customer.destroy_all
ProductOrder.destroy_all
Order.destroy_all
AdminUser.destroy_all

csv_file = Rails.root.join("db/laptops.csv")
csv_data = File.read(csv_file)

laptops_data = CSV.parse(csv_data, headers: true, encoding: "iso-8859-1")

laptops_data.each do |laptop|
  category = Category.find_or_create_by(name: laptop["Manufacturer"])
  if category.valid?
    product = Product.create(
      name:             laptop["Model Name"],
      screen:           laptop["Screen"],
      screen_size:      laptop["Screen Size"],
      cpu:              laptop["CPU"],
      gpu:              laptop["GPU"],
      ram:              laptop["RAM"],
      storage:          laptop["Storage"],
      operating_system: laptop["Operating System"],
      operating_system_version: laptop["Operating System Version"],
      price:            Faker::Number.decimal(l_digits: 4, r_digits: 2),
      category:         category
    )
    query = URI.encode_www_form_component([category.name + " laptop", product.name + " laptop"].join(","))
    downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{query}")
    product.image.attach(io:       downloaded_image,
                       filename: "m-#{[category.name,
                                       product.name].join('-')}.jpg")
    sleep(1)
  else
    puts "Invalid category #{laptop['Manufacturer']} for products."
  end
end

puts "Created #{Category.count} categories."
puts "Created #{Product.count} products."
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?