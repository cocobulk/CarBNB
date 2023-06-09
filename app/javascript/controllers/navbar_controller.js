import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content"];

  toggle() {
    const contentTarget = this.contentTarget;
    const isCollapsed = contentTarget.getAttribute("data-collapsible-collapsed-value") === "true";

    if (isCollapsed) {
      contentTarget.setAttribute("data-collapsible-collapsed-value", "false");
      contentTarget.classList.remove("collapsed");
    } else {
      contentTarget.setAttribute("data-collapsible-collapsed-value", "true");
      contentTarget.classList.add("collapsed");
    }
  }
}
