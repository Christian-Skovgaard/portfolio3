'use strict';

//make correct number ✅
//make input a let in js
//compare imputted number and correct number ✅
//make if-statement that increase if not correct
//make highscore system work
//make game reset


function getRandomNumber () {
    return Math.floor(Math.random() * 21)
}
const correctNumber =getRandomNumber()

const playerInputField =  document.querySelector('input')
const checkButton = document.querySelector(".check")


let isCorrect = false

function checkIfCorrect () {
    let guess = playerInputField.value
    if (Number(correctNumber) === Number(guess)) {
        isCorrect = true
    }
    else {
        isCorrect = false
    }
    console.log(isCorrect)
}

checkButton.addEventListener('click', checkIfCorrect)
