window.addEventListener('load', function(){

  const pullDownButton = document.getElementById("lists")
  const pullDownParents = document.getElementById("pull-down")

  pullDownButton.addEventListener('click', function() {
    if (pullDownParents.getAttribute("style") == null){
      pullDownParents.setAttribute("style", "display:block;")
    } else {
      pullDownParents.removeAttribute("style", "display:block;")
    }
  })
})