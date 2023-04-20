import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  dropdown() {
    this.menuTarget.classList.toggle("hidden");
  }
}
