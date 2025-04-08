let rabbitName = "Monty" //avoid conflict

class Rabbit {
    name: string;
    constructor(name:string) {
        this.name = name;
    }
}
    const r = new Rabbit("Python"); //create instance

    console.log(r.name);       // prints "Python"
    console.log(rabbitName);   // prints "Monty"
