import { Controller } from "stimulus";

export default class extends Controller {
    static targets = ["statusSelect"];

    change(event) {
        const status = event.target.value;
        this.loadUsers(status);
    }

    loadUsers(status) {
        const url = `/mentors/filter_by_status?status=${status}`;
        const frame = document.getElementById("users-container");
        frame.setAttribute("src", url);
    }
}