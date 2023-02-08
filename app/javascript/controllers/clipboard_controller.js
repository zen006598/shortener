import { Controller } from "@hotwired/stimulus"
 
export default class extends Controller {
  static targets = [ 'url' ]
  copy() {
    const url = this.urlTarget
    url.select()
    navigator.clipboard.writeText(url.value)
  }
}
