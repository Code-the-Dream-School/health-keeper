import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("PDF Menu controller connected")
    this.injectPdfMenuItem()
  }

  injectPdfMenuItem() {
    const dropdown = document.querySelector('.dropdown-menu')
    if (dropdown) {
      const menuItem = `
        <li>
          <a href="/pdfs" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
            View PDFs
          </a>
        </li>
      `
      dropdown.insertAdjacentHTML('beforeend', menuItem)
    }
  }
} 