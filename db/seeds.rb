# 親ジャンルの作成
upper_body = Genre.find_or_create_by!(name: '上半身')
lower_body = Genre.find_or_create_by!(name: '下半身')

# 上半身のサブジャンル
['肩', '胸', '背中', 'お腹', '腕'].each do |subgenre_name|
  upper_body.subgenres.find_or_create_by!(name: subgenre_name)
end

# 下半身のサブジャンル
['太もも', 'ふくらはぎ', 'お尻'].each do |subgenre_name|
  lower_body.subgenres.find_or_create_by!(name: subgenre_name)
end

# その他のジャンル
genres = [
  { name: 'Action' },
  { name: 'Adventure' },
  { name: 'Comedy' }
]

genres.each do |genre_data|
  Genre.find_or_create_by!(name: genre_data[:name])
end

# ユーザーの作成
users = [
  { email: 'user1@example.com', password: 'password1', name: 'User One' },
  { email: 'user2@example.com', password: 'password2', name: 'User Two' },
  { email: 'user3@example.com', password: 'password3', name: 'User Three' }
]

users.each do |user|
  User.find_or_create_by!(email: user[:email]) do |u|
    u.password = user[:password]
    u.name = user[:name]
  end
end

# 管理者の固定キー
Admin.find_or_create_by!(email: 'admin@muscle') do |admin|
  admin.password = 'muscle'
end
