const hourE2 = document.getElementById("hour");
const minuteE2  = document.getElementById("minute");
const secondE2=document.getElementById("second");
const ampmE2 = document.getElementById("ampm");
const milisecondE2=document.getElementById("milisec")

function updateClock(){
    let h = new Date().getHours();
    let m = new Date().getMinutes();
    let s = new Date().getSeconds();
    let ms = new Date().getMilliseconds

    if (h>12){
        h=h-12;
        ampm="PM";
    }
    if (h<10){
        h="0"+h;
    }
    if (m<10){
        m="0"+m;
    }
    if (s<10){
        s="0"+s;
    }
    hourE2.innerText=h;
    minuteE2.innerText=m;
    secondE2.innerText=s;
   
    ampmE2.innerText=ampm;
}
setInterval(updateClock,1000);










