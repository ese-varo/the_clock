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
let total_time_seconds = 0;
let interval;
let difference = 0;
let saved_time = 0;
let previous_time = 0;
let paused = false;
let running = false;
let records = [];
let stopwatch_id = '';

function startTimer() {
  interval = setInterval(showTime, 1000);
  running = true;
  paused = false;
}

function stopTimer() {
  clearInterval(interval);
  saved_time = total_time_seconds;
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
  total_time_seconds = 0;
  difference = 0;
  previous_time = 0;
  saved_time = 0;
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
    difference = total_time_seconds - previous_time;
    if(previous_time === 0) {
      saveRecordOfStopwatch();
    } else {
      saveLapOfStopwatch();
    }
    previous_time = total_time_seconds;
  }
});

function saveRecordOfStopwatch() {
  fetch(`/users/${userId}/stopwatches`, {
    method: 'POST',
    body: JSON.stringify({label: labelInput.value, time: total_time_seconds, difference: difference}),
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': Rails.csrfToken()
    },
    credentials: 'same-origin'
  }).then(response => response.json())
  .then(result => stopwatch_id = result.id);
}

function saveLapOfStopwatch() { 
  fetch(`/users/${userId}/stopwatches/${stopwatch_id}`, {
    method: 'PATCH',
    body: JSON.stringify({time: total_time_seconds, difference: difference}),
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': Rails.csrfToken()
    }
  });
}

function showTime() {
  total_time_seconds += 1;
  let hours = Math.floor(total_time_seconds / 3600);
  let minutes = Math.floor(total_time_seconds / 60);
  let seconds = Math.floor(total_time_seconds % 60);
  hoursLabel.innerText = hours.toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false});
  minutesLabel.innerText = minutes.toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false});
  secondsLabel.innerText = seconds.toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false});
}
