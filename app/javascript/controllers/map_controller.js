import { Controller } from "@hotwired/stimulus"
import GMaps from 'gmaps/gmaps.js';

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    // const mapElement = document.getElementById('map');// don't try to build a map if there's no div#map to inject in
    console.log("map connected")
    console.log("salut")
    const map = new GMaps({ el: '#map', lat: 0, lng: 0 });
    const markers = JSON.parse(this.element.dataset.markers);
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
