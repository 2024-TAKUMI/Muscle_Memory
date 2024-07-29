import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('turbolinks:load', () => {
  const backButton = document.querySelectorAll('.back-button');
  backButton.forEach(button => {
    button.addEventListener('click', () => {
      window.history.back();
    });
  });
});
