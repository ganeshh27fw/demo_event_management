document.addEventListener("turbolinks:load", function() {
  const searchBox = document.getElementById("search_box");

  if (searchBox) {
    searchBox.addEventListener("input", function() {
      const query = searchBox.value;

      fetch(`/events?query=${query}`, {
        headers: {
          "X-Requested-With": "XMLHttpRequest"
        }
      })
      .then(response => response.text())
      .then(data => {
        document.getElementById("search_results").innerHTML = data;
      })
      .catch(error => console.error('Error:', error));
    });
  }
});
