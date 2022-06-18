et x = "";
let myObj = {
  "name":"John",
  "age":30,
  "cars": {
  "car1":"Ford",
  "car2":"BMW",
  "car3":"Fiat"
  }
}
myObj.cars.car2 = "Mercedes";

for (let i in myObj.cars) {
  x += myObj.cars[i] + "<br>";
}

document.getElementById("demo").innerHTML = x;