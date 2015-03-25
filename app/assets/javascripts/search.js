$(document).ready(function() {
  $("#search-button").on("click", filterUrls);

  function filterUrls() {
    searchTerm = new RegExp($("#search").val(), "i");
    console.log(searchTerm + " " + typeof(searchTerm))
    $("li").each(function(index, element) {
      if (element.innerText.match(searchTerm)) {
        $(element).show();
      } else {
        $(element).hide();
      }
    });
  };
});
