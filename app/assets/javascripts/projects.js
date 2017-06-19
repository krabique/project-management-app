// projects.js
$(document).ready( function(){
  //for dropdown info
  var acc = document.getElementsByClassName("accordion");
  var i;
  for (i = 0; i < acc.length; i++) {
    acc[i].onclick = function(){
      this.classList.toggle("active");
      var panel = this.nextElementSibling;
      if (panel.style.display === "block") {
        panel.style.display = "none";
      } else {
        panel.style.display = "block";
      }
    }
  }
  
  $('#form-users-list-search').on('keyup', function() {
  var query = this.value;
    $('.form-users-list-item').each(function(i, elem) {
      if (elem.id.toLowerCase().indexOf(query) != -1) {
          $(this).parent().css("display", "table-row");
      }else{
          $(this).parent().css("display", "none");
      }
    });
  });  
});