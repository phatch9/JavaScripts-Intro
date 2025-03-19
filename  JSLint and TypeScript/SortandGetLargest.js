// function swap(arr,i,j) {
//     tmp = arr[i]; arr[i] = arr[j]; arr[j] = tmp;
//     }
//         function sortAndGetLargest (arr) {
//     tmp = arr[0]; // largest elem
//     for (i=0; i<arr.length; i++) {
//         if (arr[i] > tmp) tmp = arr[i];
//         for (j=i+1; j<arr.length; j++)
//         if (arr[i] < arr[j]) swap(arr,i,j);
//     }
//     return tmp;
//     }
//     var largest = sortAndGetLargest([99,2,43,8,0,21,12]);
//   console.log(largest); // should be 99, but prints 0


/* Fix code through JSlint */

function swap(arr, i, j) {
    "use strict";
    var tmp = arr[i];
    arr[i] = arr[j];
    arr[j] = tmp;
}

function sortAndGetLargest(arr) {
    "use strict";
    var tmp = arr[0], i, j; // Declare variables properly

    for (i = 0; i < arr.length; i++) {
        if (arr[i] > tmp) {
            tmp = arr[i]; // fix the sort to find the largest element
        }
        for (j = i + 1; j < arr.length; j++) {
            if (arr[i] < arr[j]) {
                swap(arr, i, j); // Sort in descending order
            }
        }
    }
    return tmp;
}

var largest = sortAndGetLargest([99, 2, 43, 8, 0, 21, 12]);
console.log(largest); // prints 99 instead
