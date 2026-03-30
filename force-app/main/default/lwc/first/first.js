import { LightningElement , track } from 'lwc';

export default class First extends LightningElement {
    greeting = 'Hello, World!';
    message = 'Welcome to Lightning Web Components!';
    color = 'lightblue';

   @track product = {
        name: 'Laptop',
        price: 999.99,
        stock: 10  
    }

    get isProductVisible() { 
        return this.product.stock > 0;
    }
    handleStockChange(event) {
        this.product.stock = event.target.value; 
    }

    input1 ;
    input2 ; 
    result = 0;

    handleInput1Change(event) {
        this.input1 = parseInt(event.target.value, 10) || 0; 
    }

    handleInput2Change(event) {
        this.input2 = parseInt(event.target.value, 10) || 0; 
    }

    add() {
        this.result = this.input1 + this.input2;
    }

    subtract() {
        this.result = this.input1 - this.input2;
    }

    multiply() {
        this.result = this.input1 * this.input2;
    }
    divide() {
        if (this.input2 !== 0) {
            this.result = this.input1 / this.input2;
        } else {
            this.result = 'Error: Division by zero';
        }
    }

    clear() {
        this.input1 = 0;
        this.input2 = 0;
        this.result = 0;
    }

    changeColor() {
        this.color = this.color === 'lightblue' ? 'red' : 'lightblue';
    }

}