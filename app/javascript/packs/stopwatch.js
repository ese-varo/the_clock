import Rails from "@rails/ujs"
const startBtn = document.getElementById("start");
const stopBtn = document.getElementById("stop");
const resetBtn = document.getElementById("reset");
const recordBtn = document.getElementById("record");
const pauseBtn = document.getElementById("pause");
const minutesLabel = document.getElementById("minutes");
const secondsLabel = document.getElementById("seconds");
const listRecords = document.getElementById("records");
const labelInput = document.querySelector('input[name="label"]');
const userId = recordBtn.dataset.userId;
let startTime;
let updatedTime;
let interval;
let difference;
let recordCounter = 1;
let savedTime;
let paused = false;
let running = false;

function startTimer() {
        startTime = new Date().getTime();
        interval = setInterval(showTime, 1);
        running = true;
}

startBtn.addEventListener('click', () => {
        if (!running) {
                console.log("Start timer");
                startTimer();
        }
});

stopBtn.addEventListener('click', () => {
        console.log("Stop timer");
        if (difference) {
                clearInterval(interval);       
        }
});

resetBtn.addEventListener('click', () => {
        console.log("Reset Time");
        clearInterval(interval);
        difference = 0;
        minutesLabel.innerText = "00";
        secondsLabel.innerText = "00";
        records = [];
        paused = false;
        running = false;
        recordCounter = 1;
        labelInput.value = "";
        while (listRecords.firstChild) {
                listRecords.removeChild(listRecords.lastChild);
        }
});

pauseBtn.addEventListener('click', () => {
        if (!difference) {

        } else if (!paused) {
                clearInterval(interval);
                savedTime = difference;
                paused = true;
        } else {
                startTimer();
                paused = false;
        }
});

recordBtn.addEventListener('click', () => {
        console.log(labelInput.value);
        if(!labelInput.value) {
                alert("Label is empty");
        } else {
                let li = document.createElement("li");
                li.innerText = `${recordCounter++}. Time: ${minutesLabel.textContent}:${secondsLabel.textContent}`;
                listRecords.appendChild(li);
                fetch(`/users/${userId}/stopwatches`, {
                        method: 'post',
                        body: JSON.stringify({label: labelInput.value, time: difference, user_id: userId}),
                        headers: {
                                'Content-Type': 'application/json',
                                'X-CSRF-Token': Rails.csrfToken()
                        },
                        credentials: 'same-origin'
                }).then( (response) => {
                        console.log(response.json());
                });
        }
});

function showTime() {
        updatedTime = new Date().getTime();
        if (savedTime) {
                difference = (updatedTime - startTime) + savedTime; 
        } else {
                difference = updatedTime - startTime;
        }
        let minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
        let seconds = Math.floor((difference % (1000 * 60)) / 1000);
        minutesLabel.innerText = minutes.toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false});
        secondsLabel.innerText = seconds.toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false});
}
