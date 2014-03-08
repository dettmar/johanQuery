###
#
# @description miniQuery - a tiny subset of jQuery
# @class $ and miniQuery
# @author J.Dettmar
#
###

class $
	
	constructor: (selector) ->
		
		# make sure new instance is created
		unless @ instanceof $
			return new $ selector
		
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
		
		# augment result with $ methods
		# @todo, seems to augment Array as well
		@extend result.__proto__, $::
		
		return result
	
	
	extend: (obj, mixin) ->
		
		for name, method of mixin when name isnt "extend"
			obj[name] = method
		
		return obj
	
	isHTML: (string = "") ->
		
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
	
	add: -> # @todo
	filter: -> # @todo
	
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
		
		return @
	
	
	find: (selector) ->
		
		result = []
		@each (i, el) =>
			@each.call el.querySelectorAll(selector), ->
				result.push @
		
		return result
	
	
	map: (callback) ->
		
		result = []
		
		@each (i, element) =>
			result.push callback.call element, i, element
		
		return result
	
	
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
		
		return result
	
	
	children: ->
		
		result = []
		
		@each (i, el) =>
			@each.call el.children, ->
				if not (@ in result)
					result.push @
		
		return result
	
	
	siblings: ->

	
	###
	#
	# Class manipulation methods
	#
	###
	
	_manipulateClass: (classNames, method) ->
		
		@each ->
			@classList[method].apply @classList, classNames.split " "
	
	hasClass: (classNames) -> @_manipulateClass classNames, "contains"
	addClass: (classNames) -> @_manipulateClass classNames, "add"
	removeClass: (classNames) -> @_manipulateClass classNames, "remove"
	toggleClass: (classNames) -> @_manipulateClass classNames, "toggle"
	
	
	###
	#
	# Attribute manipulation methods
	#
	###
	
	attr: (val, key) ->
		
		# if only get value, get the first elements value
		unless key?
			return JSON.parse @get(0).getAttribute val
		
		# if a set value, add to all elements
		@each ->
			@setAttribute val, JSON.stringify key
	
	
	data: (val, key) -> @attr "data-#{val}", key
	
	
	###
	#
	# Node insertion methods
	#
	###
	
	_insertNodes: (nodes, method) ->
		
		if typeof nodes is "string"
			nodes = $::parseHTML nodes
		
		unless nodes instanceof Array
			nodes = [nodes]
		
		@each (i, el) =>
			@each.call nodes, (j, node) =>
				if method is "appendChild"
					el[method] @clone.call node
				else
					el[method] @clone.call(node), el.firstChild
	
	append: (nodes) -> @_insertNodes nodes, "appendChild"
	prepend: (nodes) -> @_insertNodes nodes, "insertBefore"
	
	
	remove: ->
	
	
	###
	#
	# Node content methods
	#
	###
	
	html: (content) ->
		
		# if content isnt passed in
		unless content?
			return @get(0).innerHTML
		
		# if content is passed in
		@each ->
			@innerHTML = content

	text: (content) ->
		
		# if content isnt passed in
		unless content?
			return @get(0).innerText
		
		# if content is passed in
		@each ->
			@innerText = content
	
	clone: (deep = true) ->
		
		if @ instanceof Array
			return @map ->
				if @ instanceof HTMLElement
					@cloneNode deep
		
		if @ instanceof HTMLElement
			return @cloneNode deep
		
		@
	
	
	parseHTML: (htmlString = "") ->
		
		wrap = document.createElement 'div'
		wrap.innerHTML = htmlString
		[].slice.call wrap.childNodes
	###
	
	events?
	ajax?
	pass html string to constructor? document fragment?
	
	###
	
###
#
#	Expose $ and allow for advanced optimizations
#
###
window["$"] = window["$"] or $
window["miniQuery"] = window["miniQuery"] or $

$::["extend"] = $::extend
$::["first"] = $::first
$::["last"] = $::last
$::["eq"] = $::eq
$::["get"] = $::get
$::["each"] = $::each
$::["find"] = $::find
$::["map"] = $::map
$::["parent"] = $::parent
$::["children"] = $::children
$::["siblings"] = $::siblings
$::["add"] = $::add
$::["filter"] = $::filter
$::["hasClass"] = $::hasClass
$::["addClass"] = $::addClass
$::["removeClass"] = $::removeClass
$::["toggleClass"] = $::toggleClass
$::["attr"] = $::attr
$::["data"] = $::data
$::["append"] = $::append
$::["prepend"] = $::prepend
$::["remove"] = $::remove
$::["html"] = $::html
$::["text"] = $::text
