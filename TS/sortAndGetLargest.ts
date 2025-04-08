function swap (arr:number[], i: number, j:number):void 
{
    const tmp = arr[i];  // Store the value at index i
    arr[i] = arr[j];     // Swap value i with value at j
    arr[j] = tmp;        // Assign stored value to index j
}
    function sortAndGetLargest (arr:number[]):number {
        let tmp = arr[0];
        for ( let  i=0; i < arr.length; i++ )
            {
                if (arr[i] >tmp) tmp = arr[i]; // Update largest number if a bigger one is found
                for ( let j=0; j < arr.length; j++) {
                    if (arr[i]<arr[j]) {
                    swap (arr,i,j);} // Swap if the current element is smaller
                }
            }
    return tmp;
    }
    const largest = sortAndGetLargest([99,2,43,8,0,21,12]);
    console.log(largest); // should be 99