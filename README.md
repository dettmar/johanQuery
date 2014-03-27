# johanQuery
A tiny subset of jQuery - not nearly as awesome, but small. __911 B__ gzipped small.

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
This is only an experiment - me trying learning about how jQuery works. In other words __do not use this in production!__

## Todo
* Tests against jQuery
* Support second context parameter `$("selector", context)`
* Support multiple events per element
* Support namespaced events
* Support data to be passed with events
* Support `.siblings()`

## Browser support
IE 10+, Chrome, Firefox, Safari, Opera