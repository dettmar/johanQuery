# johanQuery
A tiny subset of jQuery - not nearly as awesome, but small. __911 B__ gzipped small.

## Methods

### Create an instance

As with jQuery you can pass the following things into constructor __`$( selector )`__:

* CSS-selector
* HTML string
* `window` or `document`
* `HTMLElement`
* `NodeList`
* `Function` (for Document ready)
* `johanQuery` object
  
 
_On an instanciated object, you've got these methods at hand:_

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

`window.johanQuery` and `window.$` are made available if they do not already exist. To make sure that your `$("#superElement")` or `johanQuery("#superElement")` is actually a `johanQuery` object, try `$("#superElement") instanceof johanQuery`.

## Todo
* Tests against jQuery
* Support second context parameter `$("selector", context)`
* Support multiple events per element
* Support namespaced events
* Support data to be passed with events
* Support `.siblings()`

## Browser support
IE 10+, Chrome, Firefox, Safari, Opera