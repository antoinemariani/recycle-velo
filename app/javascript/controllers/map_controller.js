import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  // connect() {
  //   mapboxgl.accessToken = this.apiKeyValue

  //   this.map = new mapboxgl.Map({
  //     container: this.element,
  //     style: "mapbox://styles/mapbox/streets-v10"
  //   })
  // }

  connect() {
    const mapElement = document.getElementById('map');
    if (mapElement) { // don't try to build a map if there's no div#map to inject in
      const map = new GMaps({ el: '#map', lat: 0, lng: 0 });
      const markers = JSON.parse(mapElement.dataset.markers);
      map.addMarkers(markers);
      if (markers.length === 0) {
        map.setZoom(2);
      } else if (markers.length === 1) {
        map.setCenter(markers[0].lat, markers[0].lng);
        map.setZoom(14);
      } else {
        map.fitLatLngBounds(markers);
      }
    }
  }
}
