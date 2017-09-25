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

import socket from "./socket"

window.onload = function(e) { 
    
    // variables;
    let url = window.location;
    let params = $.getParams(url.search);

    // elements;
    let sorted = document.getElementsByClassName('sortable')
    sorted = [].slice.call(sorted);

    // called once directly on mount;
    onInit.init();

    const reSort = (e) => {
        let name = $.camelCase(e.target.innerHTML)
        let upOrDown = params["sortby"] === name ?  1 - params['asc'] : params['asc'] || 0
        location.href = url.origin + `?asc=${upOrDown}&sortby=${name}`;
    }

    sorted.map(a => {
        a.addEventListener('click', reSort);
    });
}

// helper functions
const $ = {
    getEl: function(e) {
        var text = [];
        if (e instanceof Object) {
            for (var i = 0; i < e.length; ++i) {
                text.push(e[i]);
            }
            return text;
        } else {
            return [e];
        }
    },
    camelCase: function(str) {
        return str.replace(/\s/g, '_').toLowerCase();
    },
    getParams: function(query) {
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
    },
}

const onInit = {
    init: function() {
        // add exit button to flash message;
        let alertExit = document.getElementById('exit');
        if (alertExit) {
            let alert = document.getElementById('alert');
            alertExit.onclick = function() {
                alert.style.display = "none";
            }
        };

        let params = $.getParams(window.location.search);
        let sortby = params["sortby"] || 'name';
        
        // elements;
        let sorted = document.getElementsByClassName('sortable')
        sorted = [].slice.call(sorted);

        sorted.map(a => {
            if ($.camelCase(a.innerHTML) === sortby) {
                let classNm = params["asc"] == "0" ? ' arrow-down' : 'arrow-up';
                a.previousSibling.className += " " + classNm;
            }
        });
    }
}
