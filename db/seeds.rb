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

# 展示用訂單 Seed
# 使用虛構資料，方便展示後台不同訂單狀態

admin = User.find_by!(email: "admin@test.com")

demo_orders = [
  {
    name: "展示顧客 01",
    state: :order_placed,
    items: [ [ "卡比", 1 ], [ "怨虎龍", 1 ] ]
  },
  {
    name: "展示顧客 02",
    state: :order_placed,
    items: [ [ "林克【王國之淚】", 1 ] ]
  },
  {
    name: "展示顧客 03",
    state: :order_placed,
    items: [ [ "賽菲羅斯", 2 ] ]
  },
  {
    name: "展示顧客 04",
    state: :paid,
    items: [ [ "豆狸 & 粒狸", 1 ], [ "卡比", 1 ] ]
  },
  {
    name: "展示顧客 05",
    state: :shipping,
    items: [ [ "小螢【幻界】", 1 ], [ "小擬【幻界】", 1 ] ]
  },
  {
    name: "展示顧客 06",
    state: :shipping,
    items: [ [ "小姬【秩序篇】", 1 ], [ "飯田【秩序篇】", 1 ] ]
  },
  {
    name: "展示顧客 07",
    state: :shipped,
    items: [ [ "鬼福【塗擊隊】", 1 ] ]
  },
  {
    name: "展示顧客 08",
    state: :shipped,
    items: [ [ "曼曼【塗擊隊】", 1 ], [ "莎莎【塗擊隊】", 1 ] ]
  },
  {
    name: "展示顧客 09",
    state: :order_cancelled,
    items: [ [ "怨虎龍", 1 ] ]
  }
]

demo_orders.each do |demo|
  # 以展示顧客名稱識別，避免重複建立
  order = Order.find_or_initialize_by(
    user: admin,
    billing_name: demo[:name]
  )

  next if order.persisted?

  order.assign_attributes(
    billing_address: "臺北市信義區市府路1號",
    shipping_name: demo[:name],
    shipping_address: "臺北市中正區重慶南路一段122號",
    payment_method: "信用卡"
  )

  # 建立訂單明細，保留下單時的商品名稱與價格
  demo[:items].each do |title, quantity|
    product = Product.find_by!(title: title)

    order.product_lists.build(
      product_name: product.title,
      product_price: product.price,
      quantity: quantity
    )
  end

  # 訂單總額依明細計算
  order.total = order.product_lists.sum do |item|
    item.product_price * item.quantity
  end

  ActiveRecord::Base.transaction do
    order.save!

    # 透過 AASM 事件轉換狀態
    case demo[:state]
    when :paid
      order.make_payment!
    when :shipping
      order.make_payment!
      order.ship!
    when :shipped
      order.make_payment!
      order.ship!
      order.deliver!
    when :order_cancelled
      order.cancel_order!
    end
  end

  puts "建立展示訂單：#{demo[:name]}（#{order.aasm_state}）"
end
