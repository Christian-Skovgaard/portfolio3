'use strict';

//make correct number ✅
//make input a let in js
//compare imputted number and correct number
//make if-statement that increase if not correct
//make highscore system work
//make game reset


function getRandomNumber () {
    return Math.floor(Math.random() * 21)
}
const correctNumber =getRandomNumber()

console.log(correctNumber)

const playerInputField =  document.querySelector('input')
const guessButton = document.querySelector('.')

//button class is "guess"