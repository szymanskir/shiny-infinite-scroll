$(document).ready(function() {
  const observer = new IntersectionObserver(function(entries) {
    if (entries[0].intersectionRatio > 0) {
      console.log(Math.random());
      Shiny.setInputValue("screen_end_reached", true, { priority: "event" })
    }
  });
  
  observer.observe(document.querySelector("#end"));
})