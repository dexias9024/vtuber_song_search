import { Tooltip, Popover } from 'bootstrap'; // ユーザーが必要なコンポーネントのみをインポート

import "@hotwired/turbo-rails"
import "controllers"

import Rails from "@rails/ujs"
import { Turbo } from "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
import { csrfToken } from "rails-ujs"

Rails.start()
Turbo.start()
ActiveStorage.start()

// ページが読み込まれたときに実行されるコード
document.addEventListener("DOMContentLoaded", () => {
  // ページが読み込まれた後にBootstrap JavaScriptコンポーネントを初期化
  const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new Tooltip(tooltipTriggerEl)
  })

  const popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
  const popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
    return new Popover(popoverTriggerEl)
  })
})