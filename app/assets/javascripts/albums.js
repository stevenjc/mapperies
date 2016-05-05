function test() {
  document.getElementById("access").style.display = "block";
}

function showFriends() {
    var selopt = document.getElementById("opts").value;
  if (selopt == "Private") {
        document.getElementById("f1").style.display = "block";
    }
    else {
      document.getElementById("f1").style.display = "none";

    }
}
