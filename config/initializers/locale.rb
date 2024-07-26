# ユーザーロケールの設定
I18n.available_locales = [:en, :ja]

# デフォルトロケールを日本語に設定
I18n.default_locale = :ja

# ロケールファイルの読み込みパスを追加
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
