'use strict';

//make correct number ✅
//compare imputted number and correct number ✅
//make if-statement that increase if not correct
//make highscore system work
//make game reset

//assign correct answer
function getRandomNumber () {
    return Math.floor(Math.random() * 21)
}
let correctNumber =getRandomNumber()


//assign html elements
const playerInputField =  document.querySelector('input')
const checkButton = document.querySelector(".check")
const scoreField = document.querySelector('.score')
const highscoreField = document.querySelector('.highscore')

//assign js var
let scoreCount = 0
let highscore;
let isCorrect = false

scoreField.textContent = scoreCount

//function that runs after check is pressed
function checkIfCorrect () {
    let guess = playerInputField.value
    scoreCount++
    if (Number(correctNumber) === Number(guess)) {
        isCorrect = true
        scoreField.textContent = scoreCount
        updateHighscore(scoreCount)
        reset()
    }
    else {
        isCorrect = false
    }
    console.log(isCorrect)
}

function updateHighscore (score) {
    if (score > highscore) {
        highscore = score
    }
}

checkButton.addEventListener('click', checkIfCorrect)

function reset () {
    correctNumber = getRandomNumber()
    scoreCount = 0
}
