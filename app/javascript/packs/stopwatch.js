import Rails from "@rails/ujs"
const startBtn = document.getElementById("start");
const resetBtn = document.getElementById("reset");
const recordBtn = document.getElementById("record");
const minutesLabel = document.getElementById("minutes");
const secondsLabel = document.getElementById("seconds");
const listRecords = document.getElementById("records");
const labelInput = document.querySelector('input[name="label"]');
const userId = recordBtn.dataset.userId;
let startTime;
let updatedTime;
let interval;
let difference;
let current_time = 0;
let previous_time = 0;
let saved_time = 0;
let paused = false;
let running = false;
let records = [];
let stopwatch_id = '';

function startTimer() {
        startTime = new Date().getTime();
        interval = setInterval(showTime, 1);
        running = true;
        paused = false;
}

function stopTimer() {
        clearInterval(interval);
        saved_time = current_time;
        paused = true;
        running = false;
        startBtn.innerText = 'Start';
}

startBtn.addEventListener('click', () => {
        if (!running) {
                console.log("Start timer");
                startTimer();
                startBtn.innerText = 'Pause';
        } else {
               stopTimer(); 
        }
});


resetBtn.addEventListener('click', () => {
        console.log("Reset Time");
        clearInterval(interval);
        current_time = 0;
        difference = 0;
        previous_time = 0;
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
                difference = current_time - previous_time;
                if(previous_time === 0) {
                        saveRecordOfStopwatch();
                } 
                else {
                        saveLapOfStopwatch();
                }
                previous_time = current_time;
        }
});

function saveRecordOfStopwatch() {
        fetch(`/users/${userId}/stopwatches`, {
                method: 'POST',
                body: JSON.stringify({label: labelInput.value, time: current_time, difference: difference}),
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
                body: JSON.stringify({time: current_time, difference: difference}),
                headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-Token': Rails.csrfToken()
                }
        });
}

function showTime() {
        updatedTime = new Date().getTime();
        if (saved_time) {
                current_time = (updatedTime - startTime) + saved_time; 
        } else {
                current_time = updatedTime - startTime;
        }
        let minutes = Math.floor((current_time % (1000 * 60 * 60)) / (1000 * 60));
        let seconds = Math.floor((current_time % (1000 * 60)) / 1000);
        minutesLabel.innerText = minutes.toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false});
        secondsLabel.innerText = seconds.toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false});
}
