import { LightningElement,track } from 'lwc';

export default class TodoLIst extends LightningElement {
    todos = [];
    @track  data = [];
    currentIndex = 0;
    loader = false;
    get currentItem() {
        return this.data[this.currentIndex] || {};
    }
    get hasData() {
        return this.data.length > 0;
    }
    

    handleAddTodo(event) {
        event.preventDefault();
        const input = this.template.querySelector('lightning-input');
        if (input.value) {
            this.todos = [...this.todos, { text: input.value , id: Date.now() }];
            input.value = '';
        }
    }

    handleDeleteTodo(event) {
        const id = event.target.dataset.id;
        this.todos = this.todos.filter((todo) => todo.id !== parseInt(id));
    }

    async fetchData() {
        this.loader = true;
        try {
            const response = await fetch('https://sfdev36-dev-ed.my.salesforce-sites.com/services/apexrest/employees');
            const data = await response.json();
            
            console.log('Data fetched:', data);
            this.data = data.employee;
        } catch (error) {
            console.error('Error fetching data:', error);
        } finally {
            this.loader = false;
        }
    }

    previous() {
        if (this.currentIndex > 0) {
            this.currentIndex -= 1;
        }
    }

    next() {
        if (this.currentIndex < this.data.length - 1) {
            this.currentIndex += 1;
        }
    }
}