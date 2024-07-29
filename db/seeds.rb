# 親ジャンルの作成
upper_body = Genre.create!(name: '上半身')
lower_body = Genre.create!(name: '下半身')

# 上半身のサブジャンル
['肩', '胸', '背中', 'お腹', '腕'].each do |subgenre_name|
  upper_body.subgenres.create!(name: subgenre_name)
end

# 下半身のサブジャンル
['太もも', 'ふくらはぎ', 'お尻'].each do |subgenre_name|
  lower_body.subgenres.create!(name: subgenre_name)
end

# その他のジャンル
genres = [
  { name: 'Action' },
  { name: 'Adventure' },
  { name: 'Comedy' }
]

genres.each do |genre_params|
  Genre.create!(genre_params)
end

# ユーザーの作成
users = [
  { email: 'user1@example.com', password: 'password1', name: 'User One' },
  { email: 'user2@example.com', password: 'password2', name: 'User Two' },
  { email: 'user3@example.com', password: 'password3', name: 'User Three' }
]

users.each do |user_params|
  User.create!(user_params)
end

# 管理者の固定キー
Admin.create!(email: 'admin@muscle', password: 'muscle')
