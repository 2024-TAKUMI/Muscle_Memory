class Public::HomesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:top, :about]

  def top
    # トップページのロジック
  end

  def about
    # アバウトページのロジック
  end
end
