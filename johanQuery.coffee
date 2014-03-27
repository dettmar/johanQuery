###
#
# @description johanQuery - a tiny subset of jQuery
# @class $ and johanQuery
# @author J.Dettmar
# @see https://github.com/dettmar/johanQuery
# @license WTFPL
#
###

class johanQuery extends Array
	
	constructor: (selector) ->
		
		# if johanQuery obj is passed in
		if selector instanceof johanQuery
			return selector
		
		# make sure new instance is created
		unless @ instanceof johanQuery
			return new johanQuery selector
				
		# augment result with johanQuery methods
		@extend @__proto__, johanQuery::
		
		if selector is window or selector is document
			@push.call @, selector
		else if selector instanceof HTMLElement
			@push.call @, selector
		else if selector instanceof Array
			@push.apply @, [].slice.call selector
		else if selector instanceof NodeList
			@push.apply @, [].slice.call selector
		else if @isHTML selector
			@push.apply @, [].slice.call @parseHTML selector
		else if selector instanceof Function
			if document.readyState is "complete" then selector()
			else document.addEventListener "DOMContentLoaded", selector
		else
			@push.apply @, [].slice.call document.querySelectorAll selector
		
		@selector = selector
		
		return @
	
	
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
	###
	
	slice: -> new johanQuery super
	
	splice: -> new johanQuery super
	
	reverse: -> new johanQuery super
	
	first: -> @slice 0, 1
	
	last: -> @slice -1
	
	eq: (num = 0) -> @slice num, num + 1
	
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
		
		new johanQuery result
	
	
	map: (callback) ->
		
		result = []

		@each (i, element) ->
			val = callback.call element, i, element
			# only add if not null
			result.push val if val?
		
		result
	
	add: (content) ->

		@push.apply @, new johanQuery content
		@
		
	
	filter: (callback) ->
		
		result = []
		
		@each (i, element) ->
			if callback.call element, i, element
				result.push @
		
		new johanQuery result
		
				
	
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
		
		new johanQuery result
	
	
	children: ->
		
		result = []
		
		@each (i, el) =>
			@each.call el.children, ->
				unless @ in result
					result.push @
		
		new johanQuery result
	
	
	
	###
		#
		# Class manipulation methods
		#
	###
	
	_manipulateClass = (classNames, method) ->
		
		@each ->
			@classList[method].apply @classList, classNames.split " "
	
	hasClass: (classNames) -> @get(0).classList.contains classNames
	
	addClass: (classNames) -> _manipulateClass.call @, classNames, "add"
	
	removeClass: (classNames) -> _manipulateClass.call @, classNames, "remove"
	
	toggleClass: (classNames) -> _manipulateClass.call @, classNames, "toggle"
	
	
	
	###
		#
		# Attribute manipulation methods
		#
	###
	
	data: (val, key) -> @attr "data-#{val}", key
	attr: (val, key) ->
		
		# if only get value, get the first elements value
		unless key?
			attr = @get(0).getAttribute val
			try attr = JSON.parse attr
			return attr
		
		# if a set value, add to all elements
		key = if typeof key is "string" then key else JSON.stringify key
		@each ->
			@setAttribute val, key
	
	
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
