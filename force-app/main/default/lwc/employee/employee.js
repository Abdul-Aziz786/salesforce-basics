import { LightningElement } from 'lwc';

export default class Employee extends LightningElement {
    salaryInput = 0;

    
    get filteredEmployees() { 
        return this.employees.filter(employee => employee.salary >= this.salaryInput);
    }


    employees = [
        { id:1, name:'Ajees', salary:30000, position:'Developer' },
        { id:2, name:'Rahim', salary:45000, position:'Tester' },
        { id:3, name:'Kumar', salary:60000, position:'Manager' },
        { id:4, name:'Ali', salary:25000, position:'Support' }
    ];

    handleSalaryChange(event) {
        this.salaryInput = event.target.value;
    }
}