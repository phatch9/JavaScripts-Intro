// name = "Monty";
// function Rabbit(name) {
//   this.name = name;
// }
// var r = Rabbit("Python");

// console.log(r.name);  // ERROR!!!
// console.log(name);    // Prints "Python"


/* fix code with JSLint */
function Rabbit(name) {
    "use strict";
    this.name = name;
}

var r = new Rabbit("Python");

console.log(r.name); // Prints "Python"

/* Output: Python */