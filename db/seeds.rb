User.find_or_create_by!(email: "admin@test.com") do |user|
  user.password = "123456"
  user.password_confirmation = "123456"
  user.is_admin = true
end

products = [
  {
    title: "卡比",
    description: "星之卡比系列",
    quantity: 20,
    price: 350,
    image: "kirby.webp"
  },
  {
    title: "怨虎龍",
    description: "魔物獵人系列",
    quantity: 20,
    price: 350,
    image: "magnamalo.webp"
  },
  {
    title: "林克【王國之淚】",
    description: "薩爾達傳說系列",
    quantity: 20,
    price: 350,
    image: "link-tears-of-the-kingdom.webp"
  },
  {
    title: "賽菲羅斯",
    description: "太空戰士系列",
    quantity: 20,
    price: 350,
    image: "sephiroth.webp"
  },
  {
    title: "豆狸 & 粒狸",
    description: "動物森友會系列",
    quantity: 20,
    price: 350,
    image: "tom-nook-timmy-tommy.webp"
  },
  {
    title: "小螢【幻界】",
    description: "斯普拉遁系列",
    quantity: 20,
    price: 350,
    image: "marie-alterna.webp"
  },
  {
    title: "小擬【幻界】",
    description: "斯普拉遁系列",
    quantity: 20,
    price: 350,
    image: "callie-alterna.webp"
  },
  {
    title: "小姬【秩序篇】",
    description: "斯普拉遁系列",
    quantity: 15,
    price: 350,
    image: "pearl-order.webp"
  },
  {
    title: "飯田【秩序篇】",
    description: "斯普拉遁系列",
    quantity: 15,
    price: 350,
    image: "marina-order.webp"
  },
  {
    title: "鬼福【塗擊隊】",
    description: "斯普拉遁系列",
    quantity: 15,
    price: 350,
    image: "big-man-splatfest.webp"
  },
  {
    title: "曼曼【塗擊隊】",
    description: "斯普拉遁系列",
    quantity: 15,
    price: 350,
    image: "frye-splatfest.webp"
  },
  {
    title: "莎莎【塗擊隊】",
    description: "斯普拉遁系列",
    quantity: 15,
    price: 350,
    image: "shiver-splatfest.webp"
  }
]

products.each do |attributes|
  attributes = attributes.dup
  image_filename = attributes.delete(:image)

  product = Product.find_or_initialize_by(
    title: attributes[:title]
  )

  product.assign_attributes(attributes)

  if image_filename && !product.image.attached?
    image_path = Rails.root.join(
      "app/assets/images/products",
      image_filename
    )

    unless File.exist?(image_path)
      raise "找不到商品圖片：#{image_path}"
    end

    product.image.attach(
      io: File.open(image_path),
      filename: image_filename,
      content_type: "image/webp"
    )
  end

  product.save!
end
