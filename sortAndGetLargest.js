function swap(arr, i, j) {
    var tmp = arr[i]; // Store the value at index i
    arr[i] = arr[j]; // Swap value i with value at j
    arr[j] = tmp; // Assign stored value to index j
}
function sortAndGetLargest(arr) {
    var tmp = arr[0];
    for (var i = 0; i < arr.length; i++) {
        if (arr[i] > tmp)
            tmp = arr[i]; // Update largest number if a bigger one is found
        for (var j = 0; j < arr.length; j++) {
            if (arr[i] < arr[j]) {
                swap(arr, i, j);
            } // Swap if the current element is smaller
        }
    }
    return tmp;
}
var largest = sortAndGetLargest([99, 2, 43, 8, 0, 21, 12]);
console.log(largest); // should be 99
