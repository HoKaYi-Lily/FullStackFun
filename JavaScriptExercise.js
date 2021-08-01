//Question 1.
//Write the code to sum all salaries and store in the variable sum. Should be 390 in the example above.

let salaries = {
    John: 100,
    Ann: 160,
    Pete: 130
}

let sum = 0;
for (let key in salaries) {
    sum += salaries[key];
}

console.log(sum);

//Question 2.	
//Create a function multiplyNumeric(obj) that multiplies all numeric properties of obj by 2

// before the call
let menu = {
    width: 200,
    height: 300,
    title: "My menu"
};

multiplyNumeric(menu);

// after the call
menu = {
    width: 400,
    height: 600,
    title: "My menu"
};

function multiplyNumeric(obj) {
    for (let key in obj) {
        if (typeof obj[key] == 'number') {
            obj[key] *= 2;
        }
    }
}
console.log(menu)

//Question 3
//Write a function checkEmailId(str) that returns true if str contains '@' and ‘.’, otherwise false. Make sure '@' must come before '.' and there must be some characters between '@' and '.'
//The function must be case -insensitive:

let line = "123@'sgg."
let secondLine = "12345"


function checkEmailId(a) {

    for (var i = 0; i < a.length; i++) {

        if (a[i] == '@' || a[i] == '.') {
            return false
        }
    }
    return true

}

console.log(checkEmailId(secondLine))


//Question 4
//4.	Create a function truncate(str, maxlength) that checks the length of the str and, 
//if it exceeds maxlength – replaces the end of str with the ellipsis character "…", to make its length equal to maxlength.
//The result of the function should be the truncated(if needed) string.

//truncate("What I'd like to tell on this topic is:", 20) = "What I'd like to te…"

//truncate("Hi everyone!", 20) = "Hi everyone!"

function truncate(str, maxlength) {
    if (str.length > maxlength) {
        var s = ""
        for (var i = 0; i < maxlength; i++) {
            s = s + str[i]
        }
        console.log(s + "...")
    }
    else {
        console.log(str)
    }
}

truncate("What I'd like to tell on this topic is:", 20)

truncate("Hi everyone!", 20)


//Question 5
//5.	Let’s try 5 array operations.
//Create an array styles with items “James” and “Brennie”.
//Append “Robert” to the end.
//Replace the value in the middle by “Calvin”.Your code for finding the middle value should work for any arrays with odd length.
//Remove the first value of the array and show it.
//Prepend Rose and Regal to the array.
//    James, Brennie
//James, Brennie, Robert
//James, Calvin, Robert
//Calvin, Robert
//Rose, Regal, Calvin, Robert

let styles = ["James", "Brennie"];
console.log(styles)
styles.push("Robert")
console.log(styles)


styles[Math.floor((styles.length - 1) / 2)] = "Calvin";

//arr = ["Robert", "Cindy", "Michael"]
//function replaceMiddle(a) {
//    var y = []
//    for (var i = 0; i < a.length; i++) {
//        if (i == Math.trunc(a.length / 2)) {
//            y.push("Calvin")
//        }
//        else {
//            y.push(a[i])
//        }
//    }
//    return y

//}

//console.log(replaceMiddle(arr))



console.log(styles)
styles.shift();
console.log(styles)
styles.unshift("Rose", "Regal")
console.log(styles)
