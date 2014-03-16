###
#
# @description johanQuery - a tiny subset of jQuery
# @class $ and johanQuery
# @author J.Dettmar
#
###

class johanQuery
	
	constructor: (selector) ->
		
		# make sure new instance is created
		unless @ instanceof johanQuery
			return new johanQuery selector
		
		@selector = selector
				
		if @selector is window or @selector is document
			result = [@selector]
		else if @selector instanceof HTMLElement
			result = [@selector]
		else if @selector instanceof NodeList
			result = [].slice.call @selector
		else if @isHTML @selector
			result = @parseHTML @selector
		else
			result = document.querySelectorAll @selector
			result = [].slice.call result
		
		# augment result with johanQuery methods
		@extend result.__proto__, johanQuery::
		
		return result
	
	
	extend: (obj, mixin) ->
		
		for name, method of mixin when name isnt "extend"
			obj[name] = method
		
		return obj
	
	
	isHTML: (string) ->
		
		regx = /^(?:\s*(<[\w\W]+>)[^>]*|#([\w-]*))$/
		regx.test string
	
	
	###
		#
		# Result manipulation methods
		#
		# @method slice: -> inherited from Array
		# @method splice: -> inherited from Array
		# @method reverse: -> inherited from Array
		#
	###
	
	first: -> @slice(0, 1)
	
	last: -> @slice(-1)
	
	eq: (num = 0) -> @slice(num, num+1)
	
	get: (num = 0) -> @[num]
	
	each: (callback) -> #[].forEach.apply(@, args)
		
		arr = @
		
		unless arr instanceof Array
			arr = [].slice.call arr
		
		for element, i in arr
			# make sure the this references the element
			callback.call element, i, element
		
		@
	
	
	find: (selector) ->
		
		result = []
		
		@each (i, el) =>
			@each.call el.querySelectorAll(selector), ->
				result.push @
		
		result
	
	
	map: (callback) ->
		
		result = []
		
		@each (i, element) =>
			result.push callback.call element, i, element
		
		result
	
	add: (content) ->

		@concat johanQuery content
		
	
	filter: (callback) ->
		
		result = []
		
		@each (i, element) ->
			if callback.call element, i, element
				result.push @
		
		result
		
				
	
	###
		#
		# DOM traversal methods
		#
	###
	
	parent: ->
		
		result = []
		
		@each ->
			if @parentElement? and not (@parentElement in result)
				result.push @parentElement
		
		result
	
	
	children: ->
		
		result = []
		
		@each (i, el) =>
			@each.call el.children, ->
				if not (@ in result)
					result.push @
		
		result
	
	
	siblings: ->

	
	
	###
		#
		# Class manipulation methods
		#
	###
	
	_manipulateClass: (classNames, method) ->
		
		@each ->
			@classList[method].apply @classList, classNames.split " "
	
	hasClass: (classNames) -> @get(0).classList.contains classNames
	
	addClass: (classNames) -> @_manipulateClass classNames, "add"
	
	removeClass: (classNames) -> @_manipulateClass classNames, "remove"
	
	toggleClass: (classNames) -> @_manipulateClass classNames, "toggle"
	
	
	
	###
		#
		# Attribute manipulation methods
		#
	###
	
	data: (val, key) -> @attr "data-#{val}", key
	attr: (val, key) ->
		
		# if only get value, get the first elements value
		unless key?
			return JSON.parse @get(0).getAttribute val
		
		# if a set value, add to all elements
		@each ->
			@setAttribute val, JSON.stringify key
	
	
	###
		#
		# Node insertion methods
		#
	###
	
	_insertNodes = (nodes, method) ->
		
		if typeof nodes is "string"
			nodes = @parseHTML nodes
		
		unless nodes instanceof Array
			nodes = [nodes]
		
		@each (i, el) =>
			@clone.call(nodes).each (j, node) ->
					el[method] node, el.firstChild
	
	append: (nodes) -> _insertNodes.call @, nodes, "appendChild"
	
	prepend: (nodes) -> _insertNodes.call @, nodes, "insertBefore"
	
	remove: ->
		
		@each ->
			@parentElement?.removeChild @
	
	
	
	###
		#
		# Node content methods
		#
	###
	
	_innerContent = (content, method) ->
		
		# if content isnt passed in
		unless content?
			return @get(0)[method]
		
		# if content is passed in
		@each ->
			@[method] = content
		
	html: (content) ->
		
		_innerContent.call @, content, "innerHTML"

	text: (content) ->
		
		_innerContent.call @, content, "innerText"
	
	clone: (deep = true) ->
		
		@map ->
			if @ instanceof HTMLElement
				@cloneNode deep
	
	
	parseHTML: (htmlString = "") ->
		
		wrap = document.createElement 'div'
		wrap.innerHTML = htmlString
		[].slice.call wrap.childNodes
	
	
	###
		#
		# Events
		#
	###
	
	# @todo: namespacing? data? multiple events?
	on: (eventName, callback) ->
		
		@each ->
			@["on#{eventName}"] = callback.bind @
		
	off: (eventName) ->
			
		@each ->
			@["on#{eventName}"] = null
	
	trigger: (eventName, data) ->
		
		@each ->
			@dispatchEvent new CustomEvent eventName, data

	
###
	#
	#	Expose johanQuery and allow for advanced optimizations
	#
###
window["$"] = window["$"] or johanQuery
window["johanQuery"] = window["johanQuery"] or johanQuery

#$::["extend"] = $::extend
#$::["isHTML"] = $::isHTML
#$::["first"] = $::first
#$::["last"] = $::last
#$::["eq"] = $::eq
#$::["get"] = $::get
#$::["each"] = $::each
#$::["find"] = $::find
#$::["map"] = $::map
#$::["add"] = $::map
#$::["filter"] = $::filter
#$::["parent"] = $::parent
#$::["children"] = $::children
#$::["siblings"] = $::siblings
#$::["hasClass"] = $::hasClass
#$::["addClass"] = $::addClass
#$::["removeClass"] = $::removeClass
#$::["toggleClass"] = $::toggleClass
#$::["attr"] = $::attr
#$::["data"] = $::data
#$::["append"] = $::append
#$::["prepend"] = $::prepend
#$::["remove"] = $::remove
#$::["html"] = $::html
#$::["text"] = $::text
