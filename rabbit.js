var rabbitName = "Monty"; //avoid conflict
var Rabbit = /** @class */ (function () {
    function Rabbit(name) {
        this.name = name;
    }
    return Rabbit;
}());
var r = new Rabbit("Python"); //create instance
console.log(r.name); // prints "Python"
console.log(rabbitName); // prints "Monty"
