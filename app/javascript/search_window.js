window.addEventListener('load', function(){

  const searchButton = document.getElementById("detailed-search")
  const searchWindow = document.getElementById("search-window")

  searchButton.addEventListener('click', function() {
    if (searchWindow.getAttribute("style") == null){
      searchWindow.setAttribute("style", "display:block;")
    } else {
      searchWindow.removeAttribute("style", "display:block;")
    }
  })
})