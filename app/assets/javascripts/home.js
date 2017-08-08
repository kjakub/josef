function initAutoComplete() {

    var input = document.getElementById('rental_location');
    
    autocomplete = new google.maps.places.Autocomplete(input);

    autocomplete.addListener('place_changed', function() {
      var place = autocomplete.getPlace();
      if (!place.geometry) {
        window.alert("No details available for input: '" + place.name + "'");
        return;
      }
      document.getElementById('rental_lat').value = place.geometry.location.lat();
      document.getElementById('rental_lng').value = place.geometry.location.lng();
    });


}