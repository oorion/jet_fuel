$(document).ready(function() {
  $("#search-button").on("click", filterUrls);

  function filterUrls() {
    var searchTerm = new RegExp($("#search").val(), "i");
    $("li").each(function(index, element) {
      if (element.innerText.match(searchTerm)) {
        $(element).show();
      } else {
        $(element).hide();
      }
    });
  }
});
