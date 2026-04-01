import { LightningElement, track } from "lwc";

export default class TodoLIst extends LightningElement {
  todos = [];

  handleAddTodo(event) {
    event.preventDefault();
    const input = this.template.querySelector("lightning-input");
    if (input.value) {
      this.todos = [...this.todos, { text: input.value, id: Date.now() }];
      input.value = "";
    }
  }

  handleDeleteTodo(event) {
    const id = event.target.dataset.id;
    this.todos = this.todos.filter((todo) => todo.id !== parseInt(id));
  }
}
