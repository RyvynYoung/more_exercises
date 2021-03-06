console.log("Hello, " + 'Ryvyn');
console.log(100)
console.log(100-50)
console.log(100 + '100')

var product = 100*100;
console.log("The result is: " + product);

var product = 100*100;
console.log("The result is: " + product);

var name = 'Ryvyn';
var hobby1 = 'reading'
var hobby2 = 'cooking'

console.log("Hi I'm "  + name + '.');
console.log("My hobbies are " + hobby1 + " and " + hobby2 + ".")


// to see your browsers console you can use the following shortcuts Option + ⌘ + J (on macOS), or Shift + CTRL + J (on Windows/Linux).

// Boolean types and using ! as not operator
var isTrue = true;
console.log(isTrue);
console.log(!isTrue);
console.log(!!isTrue);
console.log(!!!isTrue);

// Boolean expression evaluation
var isGreater = 1>2;
console.log(isGreater)

// and = && both expressions must be true
var comparenumb = (9<=10) && (5==="5");
console.log(comparenumb)

var isGreater = 1>2;
console.log(isGreater)

var comparenumb = (9<=10) && (5=="5");
console.log(comparenumb)

var comparenumb = (9<=10) && (5=="5");
console.log(comparenumb)

// or operator || is True if either expression is True
var comparenumb = (9<=10) || (5=="5");
console.log(comparenumb)

// if then statements
var comparenumb = (9<=10) || (5=="5");
if (comparenumb){
  console.log("the expression is true");
}else {
  console.log("the expression is not true")
}

// simple game in JavaScript, currently have to enter the user guess manually
// defining functions, generating random numbers, function to evaluating number
playGame();

function playGame(){
  var userGuess = 25;
  var randomNumber = getRandomNumber();
  compareNumbers(randomNumber, userGuess);
}

function compareNumbers(randomNumber, userGuess){
  console.log(`You guessed: ${userGuess}`);
  console.log(`The random number was: ${randomNumber}`);
  
  if (randomNumber === userGuess){
    console.log("Great guess! You Win!")
  }else{
    console.log("Womp Womp :( Try Again!");
  }
}

function getRandomNumber(){    
    return Math.floor(Math.random() * 100) + 1;      
}