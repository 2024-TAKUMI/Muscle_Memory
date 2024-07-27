// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// Bootstrapのインポート
import 'bootstrap'
import '../stylesheets/application'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// 「戻る」ボタンの機能を追加
document.addEventListener('turbolinks:load', () => {
  const backButton = document.querySelectorAll('.back-button');
  backButton.forEach(button => {
    button.addEventListener('click', () => {
      window.history.back();
    });
  });
});
