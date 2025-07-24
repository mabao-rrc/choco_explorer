require 'open-uri'
require 'json'
require 'faker'

puts "🌱 Seeding started..."

# Clear existing records
Review.delete_all
CountryProduct.delete_all
ProductCategory.delete_all
Product.delete_all
Brand.delete_all
Category.delete_all
Country.delete_all

# API: Get chocolate data from OpenFoodFacts
url = "https://world.openfoodfacts.org/category/chocolates.json"
raw_data = URI.open(url).read
parsed_data = JSON.parse(raw_data)

products = parsed_data["products"].first(100) # Limit to 100 to stay efficient

products.each do |item|
  next if item["product_name"].blank?

  # Brand
  brand_name = item["brands"]&.split(",")&.first&.strip
  next unless brand_name.present?
  brand = Brand.find_or_create_by(name: brand_name) do |b|
    b.description = Faker::Company.catch_phrase
  end

  # Product
  product = Product.create!(
    name: item["product_name"],
    ingredients: item["ingredients_text"] || "Unknown ingredients",
    nutrition_info: item["nutriments"]&.map { |k,v| "#{k}: #{v}" }&.join(", ") || "No nutrition info",
    image_url: item["image_url"].presence || "https://via.placeholder.com/300x400.png?text=No+Image",
    brand: brand
  )

  # Categories
  (item["categories_tags"] || []).each do |cat_tag|
    cat_name = cat_tag.split(":").last.gsub("-", " ").capitalize
    category = Category.find_or_create_by(name: cat_name)
    ProductCategory.create!(product: product, category: category)
  end

  # Countries
  (item["countries_tags"] || []).each do |country_tag|
    country_name = country_tag.split(":").last.gsub("-", " ").capitalize
    country = Country.find_or_create_by(name: country_name)
    CountryProduct.create!(product: product, country: country)
  end

  # Faker Reviews
  rand(1..3).times do
    Review.create!(
      product: product,
      reviewer_name: Faker::Name.name,
      rating: rand(1..5),
      comment: Faker::Quote.famous_last_words
    )
  end
end

  # Mark a few products as Bestsellers
  puts "Marking a few products as Bestsellers..."
  Product.limit(3).each do |product|
    product.update!(name: "#{product.name} - Bestseller")
  end

puts "✅ Seeding complete!"
puts "Brands: #{Brand.count}"
puts "Products: #{Product.count}"
puts "Categories: #{Category.count}"
puts "Countries: #{Country.count}"
puts "Reviews: #{Review.count}"
puts "ProductCategories: #{ProductCategory.count}"
puts "CountryProducts: #{CountryProduct.count}"
