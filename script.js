'use strict';

//make correct number ✅
//compare imputted number and correct number ✅
//make if-statement that increase if not correct
//make highscore system work ✅
//make game reset

//assign correct answer
function getRandomNumber () {
    return Math.floor(Math.random() * 21)
}
let correctNumber =getRandomNumber()
console.log(correctNumber)

//assign html elements
const playerInputField =  document.querySelector('input')
const checkButton = document.querySelector(".check")
const scoreField = document.querySelector('.score')
const highscoreField = document.querySelector('.highscore')
const awnserBox = document.querySelector('.number')
const againButton = document.querySelector('.again')

//assign js var
let scoreCount = 0
let highscore = 100
let isCorrect = false

scoreField.textContent = scoreCount

//function that runs after check is pressed
function checkIfCorrect () {
    let guess = playerInputField.value
    scoreCount++
    if (Number(correctNumber) === Number(guess)) {
        isCorrect = true
        scoreField.textContent = scoreCount
        awnserBox.textContent = correctNumber
        updateHighscore(scoreCount)
    }
    else if (guess < 1 || guess > 20) {
        window.alert("number must be between 0 and 20")
    }
    else {
        isCorrect = false
        scoreField.textContent = scoreCount
    }
    console.log(isCorrect)
}

function updateHighscore (score) {
    if (score < highscore) {
        highscore = score
        highscoreField.textContent = highscore
    }
}

checkButton.addEventListener('click', checkIfCorrect)


//Again!-button function
function reset () {
    correctNumber = getRandomNumber()
    scoreCount = 0
    scoreField.textContent = scoreCount
    awnserBox.textContent = '?'
}

againButton.addEventListener('click', reset)


//History functionality
const historyArr = [23, 29]
document.querySelector('#history').insertAdjacentHTML()
function updateHistory (newGuess) {
    historyArr.push(newGuess)
    historyItems.textContent = historyItems
}

historyItems.textContent = historyItems