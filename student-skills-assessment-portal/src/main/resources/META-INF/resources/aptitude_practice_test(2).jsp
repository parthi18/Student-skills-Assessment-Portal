<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">




<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title> quiz </title>
    <link rel="stylesheet" type="text/css" href="">
</head><style type="text/css">body{
    margin: 0;
    background-color: #009688;
    font-family: sans-serif;
}
*{
    box-sizing: border-box;
}
.quiz-container{
    max-width: 700px;
    max-height: 500px;
    background-color: #ffffff;
    margin: 40px auto;
    border-radius: 10px;
    padding: 30px;
}
.quiz-container::after, .quiz-container::before{
    content: '';
    clear:both;
    display: table;
}
.question-number,.question,.options,.button,.answer-tracker{


}
.question-number h3{
color:#009688;
border-bottom: 1px solid #ccc;
margin: 0;
padding-bottom: 10px;
}

.question{
    font-size: 22px;
    color:black;
    padding: 20px 0;
}

.options div{
    background-color: #cccccc;
    font-size: 16px;
    color: 000000;
    padding: 15px;
    margin-bottom: 10px;
    border-radius: 5px;
    position: relative;
    overflow: hidden;
    cursor: pointer;
}
.options div.disabled{
    pointer-events: none;
}
.options div.correct{
z-index: 1;
color: #fff;
}
.options div.correct::before{
    content: '';
    position: absolute;
    left:0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: green;
    z-index: -1;
    
    animation:animateBackground 1s ease;
    animation-fill-mode: forwards;
}
@keyframes animateBackground{
    0%{
        transform: translateX(-100%);
    }
    100%{
        transform: translateX(0%);
    }

}
.options div.wrong{
z-index: 1;
color: #fff;
}
.options div.wrong::before{
    content: '';
    position: absolute;
    left:0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color:red;
    z-index: -1;
    
    animation:animateBackground 1s ease;
    animation-fill-mode: forwards;
}
@keyframes animateBackground{
    0%{
        transform: translateX(-100%);
    }
    100%{
        transform: translateX(0%);
    }

}

.button .btn{
    padding: 15px 50px;
    border-radius: 5px;
    cursor: pointer;
    background-color: #009688;
    font-size: 16px;
    color: #ffffff;
    border:none;
    display: inline-block;
    margin:15px 0 10px;
}
.answer-tracker{
    border-top: 1px solid #ccc;
    padding-top: 10px;

}
.answer-tracker div{
    height: 40px;
    width: 40px;
    background-color: #cccccc;
    display: inline-block;
    border-radius: 50%;
    margin-right:5px;
}
.answer-tracker div.correct{
    background-color: green;
    background-image: url('');
    background-position: center;;
    background-repeat: no-repeat;
    background-size: 50%;

}
.answer-tracker div.wrong{
    background-color: red;
    background-image: url('');
    background-position: center;;
    background-repeat: no-repeat;
    background-size: 50%;
}


.quiz-over{
    position: fixed;
    left:0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.9);
    z-index: 10;
    display: none;
    align-items: center;
    justify-content: center;
}
.show{
    display: flex;
}
.quiz-over .box{
    background-color: #009688;
    padding: 30px;
    border-radius: 10px;
    text-align: center;
    flex-basis: 700px;
    max-width: 700px;
    color: #ffffff;
}
.quiz-over .box h1{
    font-size: 36px;
    margin:0 0 20px;
}
.quiz-over .box button{
    padding: 15px 50px;
    border:none;
    background-color: #FF9800;
    border-radius: 5px;
    font-size: 16px;
    margin:15px 0 20px;
    color: #ffffff;

}</style>
<body>
<div class="quiz-container">
    <div class="question-number">
        <h3>Question <span class="question-num-value">1</span> of <span class="total-question"></span></h3>
    </div>
    <div class="question">
        
    </div>
    
    <div class="options">
        <div id="0" class="option1" onclick="check(this)"></div>
        <div id="1" class="option2" onclick="check(this)"></div>
        <div id="2" class="option3" onclick="check(this)"></div>
        <div id="3" class="option4" onclick="check(this)"></div>
    </div>
    <div class="button">
        <button type="button" class="btn" onclick="next()">Next</button>
    </div>
    <div class="answer-tracker">
       

    </div>
</div>
<div class="quiz-over">
    <div class="box">
    <h1>
        Good Try!
        <br>
        You got <span class="correct-answers"></span> out of <span class="total-question2"></span> Answers Correct! 
        <br>That's <span class="percentage"></span>
        <br>
        <br>
    <button type="button" onclick="tryAgain()">TryAgain</button>
    </h1>
    
</div>
</div>
<script ></script>
</body>
<script type="text/javascript"> const options=document.querySelector(".options").children;
const answerTrakcerContainer=document.querySelector(".answer-tracker");
 const questionNumberSpan=document.querySelector(".question-num-value");
 const totalQuestionSpan=document.querySelector(".total-question");
 const correctAnswerSpan=document.querySelector(".correct-answers");
  const totalQuestionSpan2=document.querySelector(".total-question2");
  const percentage=document.querySelector(".percentage");
 
const question=document.querySelector(".question");

const op1=document.querySelector(".option1");
const op2=document.querySelector(".option2");
const op3=document.querySelector(".option3");
const op4=document.querySelector(".option4");
let questionIndex;
let index=0;
let myArray=[];
let myArr=[];
let score=0;
//question and options and answer
const questions=[
{
  q: 'What is the full form of IP?',
  options: ['Internet Provider', 'Internet Port', 'Internet Protocol', 'Internet Protocol'],
  answer:0
},{
  q: 'Who is the founder of Microsoft?',
  options: ['Internet', 'Internet', 'Internet', 'Internet'],
  answer:3
},{
  q: '1 byte = ?',
  options: ['Provider', 'Port', 'Protocol', 'P'],
  answer:1
},{
  q: 'The C programming language was developed by?',
  options: ['Brendan Eich', 'Dennis Ritchie', 'Guido van Rossum'],
  answer:2
},{
  q: 'What does CC mean in emails?',
  options: ['Carbon Copy', 'Internet Port', 'other', 'Creative Commons'],
  answer:1
},
]


//set question and options and question number

totalQuestionSpan.innerHTML=questions.length;

function load(){
    questionNumberSpan.innerHTML=index+1;
  question.innerHTML=questions[questionIndex].q;
  op1.innerHTML=questions[questionIndex].options[0];
  op2.innerHTML=questions[questionIndex].options[1];
  op3.innerHTML=questions[questionIndex].options[2];
  op4.innerHTML=questions[questionIndex].options[3];
  index++;
}


function check(element){
    if(element.id==questions[questionIndex].answer) {
        console.log("correct")
        element.classList.add("correct");
        updatedAnswerTracker("correct")
        score++;
        console.log("score:"+score)
    }
    else{
        element.classList.add("wrong");
        updatedAnswerTracker("wrong")
    }
    disabledOptions()
}

function disabledOptions(){
for (let i = 0; i <options.length; i++) {
    options[i].classList.add("disabled");
    if (options[i].id==questions[questionIndex].answer){
        options[i].classList.add("correct");
    }
}
}

function enableOptions(){
    for (let i = 0; i <options.length; i++){
        options[i].classList.remove("disabled","correct","wrong");
    }

}


function validate(){
    if (!options[0].classList.contains("disabled")) {
        alert("plz select one option")
    }
    else{
        randomQuestion();
        enableOptions();
    }
}
function next(){
    validate();
}


//but we need random question
function randomQuestion(){
 let randomNumber=Math.floor(Math.random()*questions.length);
 let hitDuplicate=0;    
if (index==questions.length) {
    quizover();
    console.log("quizOver");
}
else{
    if (myArray.length>0) {
     for (let i = 0; i < myArray.length; i++) {
         if(myArray[i]==randomNumber){
           hitDuplicate=1;
           break;

         }
        }
        if (hitDuplicate==1) {
            randomQuestion();
        }
        else{
            questionIndex=randomNumber;
            load();
             myArr.push(questionIndex);
        }
    }
    if (myArray.length==0) {
        questionIndex=randomNumber;
        load();
        myArr.push(questionIndex);
    }
    console.log("myArr:"+myArr);
     myArray.push(randomNumber);
 
 }
}

function answerTrakcer(){
 
 for (let i = 0; i < questions.length; i++) {
     const div=document.createElement("div")
     answerTrakcerContainer.appendChild(div);
 }
}
 
function updatedAnswerTracker(classNam){
    answerTrakcerContainer.children[index-1].classList.add(classNam);

}


function quizover(){
    document.querySelector(".quiz-over").classList.add("show");
    correctAnswerSpan.innerHTML=score;
    totalQuestionSpan2.innerHTML=questions.length;
    percentage.innerHTML=(score/questions.length)*100 + "%";

}

function tryAgain(){
    window.location.reload();
}

window.onload=function(){
    randomQuestion();
    answerTrakcer();
}</script>
</html>