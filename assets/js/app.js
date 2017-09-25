// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"


// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

// https://stackoverflow.com/questions/901115/how-can-i-get-query-string-values-in-javascript
const getParams = query => {
    if (!query) {
      return { };
    }
    return (/^[?#]/.test(query) ? query.slice(1) : query)
      .split('&')
      .reduce((params, param) => {
        let [ key, value ] = param.split('=');
        params[key] = value ? decodeURIComponent(value.replace(/\+/g, ' ')) : '';
        return params;
      }, { });
  };

window.onload = function(e) { 
    let alertExit = document.getElementById('exit');
    if (alertExit) {
        let alert = document.getElementById('alert');
        alertExit.onclick = function() {
            alert.style.display = "none";
        }
    }

    var item = 0;
    let sorted = document.getElementsByClassName('sortable');

    function sort(e) {
        e.stopPropagation();
        let upOrDown = 1 - params['asc'] || 0;
        let name = e.target.innerHTML.toLowerCase().replace(" ", "_");
        window.location = window.location.origin + `?asc=${upOrDown}&sortby=${name}`
    }

    let params = getParams(window.location.search);
    for (var i = 0; i < sorted.length; ++i) {
        sorted[i].addEventListener('click', sort);
    }
}

