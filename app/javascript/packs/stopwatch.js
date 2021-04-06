import Rails from "@rails/ujs"
const startBtn = document.getElementById("start");
const resetBtn = document.getElementById("reset");
const recordBtn = document.getElementById("record");
const hoursLabel = document.getElementById("hours");
const minutesLabel = document.getElementById("minutes");
const secondsLabel = document.getElementById("seconds");
const listRecords = document.getElementById("records");
const labelInput = document.querySelector('input[name="label"]');
const userId = recordBtn.dataset.userId;
let totalTimeSeconds = 0;
let interval;
let difference = 0;
let savedTime = 0;
let previous_time = 0;
let paused = false;
let running = false;
let records = [];
let stopwatchId = '';

function startTimer() {
  interval = setInterval(showTime, 1000);
  running = true;
  paused = false;
}

function stopTimer() {
  clearInterval(interval);
  savedTime = totalTimeSeconds;
  paused = true;
  running = false;
  startBtn.innerText = 'Start';
}

startBtn.addEventListener('click', () => {
  if (!running) {
          startTimer();
          startBtn.innerText = 'Pause';
  } else {
         stopTimer(); 
  }
});


resetBtn.addEventListener('click', () => {
  clearInterval(interval);
  totalTimeSeconds = 0;
  difference = 0;
  previous_time = 0;
  savedTime = 0;
  hoursLabel.innerText = "00";
  minutesLabel.innerText = "00";
  secondsLabel.innerText = "00";
  records = [];
  paused = false;
  running = false;
  labelInput.value = "";
});


recordBtn.addEventListener('click', () => {
  if(!labelInput.value) {
    alert("Label is empty");
  } else if(!running) {
    alert("No time running");
  }else {
    difference = totalTimeSeconds - previous_time;
    if(previous_time === 0) {
      saveRecordOfStopwatch();
    } else {
      saveLapOfStopwatch();
    }
    previous_time = totalTimeSeconds;
  }
});

function saveRecordOfStopwatch() {
  fetch(`/users/${userId}/stopwatches`, {
    method: 'POST',
    body: JSON.stringify({label: labelInput.value, time: totalTimeSeconds, difference: difference}),
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': Rails.csrfToken()
    },
    credentials: 'same-origin'
  }).then(response => response.json())
  .then(result => stopwatchId = result.id);
}

function saveLapOfStopwatch() { 
  fetch(`/users/${userId}/stopwatches/${stopwatchId}`, {
    method: 'PATCH',
    body: JSON.stringify({time: totalTimeSeconds, difference: difference}),
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': Rails.csrfToken()
    }
  });
}

function showTime() {
  totalTimeSeconds += 1;
  let hours = Math.floor(totalTimeSeconds / 3600);
  let minutes = Math.floor(totalTimeSeconds / 60);
  let seconds = Math.floor(totalTimeSeconds % 60);
  hoursLabel.innerText = hours.toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false});
  minutesLabel.innerText = minutes.toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false});
  secondsLabel.innerText = seconds.toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false});
}
