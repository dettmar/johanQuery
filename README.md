# johanQuery
A tiny subset of jQuery - not nearly as awesome, but small. __872 B__ gzipped small.

## Methods
On an instanciated object using `$("selector")`, you've got these methods at hand:

### Result manipulation methods
* `.find()`
* `.each()`
* `.map()`
* `.add()`
* `.filter()`
* `.slice()`
* `.splice()`
* `.reverse()`
* `.first()`
* `.last()`
* `.eq()`
* `.get()`


### DOM traversal methods
* `.parent()`
* `.children()`
* `.siblings()`

### Class manipulation methods
* `.hasClass()`
* `.addClass()`
* `.removeClass()`
* `.toggleClass()`

### Attribute manipulation methods
* `.attr()`
* `.data()`

### Node insertion methods
* `.append()`
* `.prepend()`
* `.remove()`

### Node content methods
* `.html()`
* `.text()`
* `.isHTML()`

### [Events](http://en.wikipedia.org/wiki/DOM_events#Events)
* `.on()`
* `.off()`
* `.trigger()`
* `$(function() { alert("DOM loaded!") })` (Document ready)

## Special note
This is only experiment - me trying learning about how jQuery works. In other words __do not use this in production!__

## Browser support
IE 9+, Chrome, Firefox, Safari, Opera