"use strict";

// Matches patterns like '3-10'
const RANGE_PAT = /^(\d+)-(\d+)$/;

// Matches negative index values
const FROM_END_PAT = /^-(\d+)$/;

const NUM_PAT = /^-?\d+$/;

function SmartArray(...args) {
    return new Proxy(args, {
    get: function(target, prop) {
    if (typeof prop === "string" && prop.match(RANGE_PAT)) {
        // Return a subarray of the elements in the specified range,
        // INCLUDING the specified end index.
        let start = parseInt(prop.replace(RANGE_PAT, "$1"));
        let end = parseInt(prop.replace(RANGE_PAT, "$2")) + 1;
        return target.slice(start, end);
    } else if (typeof prop === "string" && prop.match(FROM_END_PAT)) {
        let index = target.length - parseInt(prop.replace(FROM_END_PAT, "$1"));
        // If the resulting index position is negative,
        // raise an exception.
        if (index < 0) throw new Error("Index out of range");
        return target[index];
        }
            else if (typeof prop === "string" && !prop.match(NUM_PAT)) {
        throw new Error("Invalid index: integer required");
        }
        return Reflect.get(...arguments);
    },
    set: function(target, prop, newVal) {
        if (!prop.match(NUM_PAT)) {
        throw new Error("Invalid index: integer required"); // throw an exception
    }
        let index = parseInt(prop);
        if (index < 0) {
        index = target.length + index;
        if (index < 0) throw new Error("Index out of range"); // if negative 
        }
        return Reflect.set(target, index, newVal);
    },
    deleteProperty: function(target, prop) {  // Specifying the 'deleteProperty' trap
        if (prop.match(FROM_END_PAT)) {
        let index = target.length - parseInt(prop.replace(FROM_END_PAT, "$1"));
        if (index < 0) throw new Error("Index out of range");
        return Reflect.deleteProperty(target, index);
        }
        return Reflect.deleteProperty(target, prop);
        }
    });
}

let arr = SmartArray('a', 'b', 'c', 'd', 'e', 'f');

console.log(arr[0]); // a
console.log(arr[4]); // e
try {
  console.log(arr['hello']); // Should throw an exception
} catch (e) {
    console.log("Exception correctly thrown.");
}

console.log(arr['2-4']); // [c, d, e]
console.log(arr['3-5']); // [d, e, f]

console.log(arr[-1]); // f
console.log(arr[-3]); // d

try {
    console.log(arr[-99]);
} catch (e) {
    console.log("Exception correctly thrown.");
}
arr[1] = 'B';
console.log(arr[1]); // B

arr[-2] = 'E';
console.log(arr[4]); // E
try {
    arr['2-4'] = 'hello';
} catch (e) {
    console.log("Exception correctly thrown.");
}
try {
    arr[3*"hello"] = 'hello';
} catch (e) {
    console.log("Exception correctly thrown.");
}
console.log(arr);
