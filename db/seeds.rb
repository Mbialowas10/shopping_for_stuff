require "URI"

Product.delete_all

39.times do
  p = Product.create(name:        Faker::Commerce.unique.product_name,
                     price_cents: rand(5000..100_000).to_i,
                     description: Faker::Hipster.sentence(word_count: rand(4..8)))

  puts "Creating #{p.name}"

  downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{p.name}")
  p.image.attach(io: downloaded_image, filename: "m-#{p.name}.jpg")
end
