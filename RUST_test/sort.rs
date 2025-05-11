// sort.rs

// Print the initial array
// Function types must be declared
fn print_arr(a: &[i32]) -> () {
    for i in a {
        print!("{} ", i);
    }
    println!("");
}

// Swap elements
fn swap(a: &mut [i32], i: usize, j: usize) -> () {
    let tmp = a[i];
    a[i] = a[j];
    a[j] = tmp;
}

// Partition function
fn partition(a: &mut [i32], low: usize, high: usize) -> usize {
    let pivot = a[high]; // take the last element as pivot 
    let mut i = low;    // index i look for position for the next smaller number 

    for j in low..high {
        if a[j] < pivot {
            swap(a, i, j); // take smaller element to the left
            i += 1; //  move partition forward
        }
    }
    swap(a, i, high);
    i
}
// After partitioning, elements smaller than the pivot will be on the left
// and all elements greater than the pivot will be on the right. 
// The pivot in the correct position, and obtain the index of the pivot.

// Quicksort function
fn quicksort(a: &mut [i32], low: usize, high: usize) -> () {
    if low < high {
        let pi = partition(a, low, high); 
        if pi > 0 {
            quicksort(a, low, pi - 1); // sort half lelf
        }
        quicksort(a, pi + 1, high);  // sort half right
    }
}

fn main() {
    let mut nums = [9, 4, 13, 2, 22, 17, 8, 9, 1];
    print_arr(&nums);
    let len = nums.len();
    if len > 0 {
        quicksort(&mut nums, 0, len - 1);
    }
    print_arr(&nums);
}
