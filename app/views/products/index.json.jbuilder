json.array!(@products) do |product|
  json.id           product.id
  json.name         product.name
  json.price        number_to_currency(product.price)
  json.description  product.description
  json.image_url    product.pictures.first.name.url
end
