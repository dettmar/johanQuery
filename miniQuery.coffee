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
		else
			result = document.querySelectorAll @selector
			result = [].slice.call result
		
		# augment result with $ methods
		@extend result.__proto__, $::
		
		return result
	
	
	extend: (obj, mixin) ->
		
		for name, method of mixin when name isnt "extend"
			obj[name] = method
		
		return obj
	

	###
	#
	# Result manipulation methods
	#
	###
	
	#slice: (args...) ->	[].slice.apply(@, args) # in Array
	#splice: (args...) -> [].splice.apply(@, args) # in Array
	#reverse: -> # in Array
	first: -> @slice(0, 1)
	last: -> @slice(-1)
	eq: (num = 0) -> @slice(num, num+1)
	each: (callback) -> #[].forEach.apply(@, args)
		
		for element, i in @
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
	# Nice-to-have traversal functions
	#
	###
	parent: ->
	children: ->
	siblings: ->
	add: ->
	filter: ->
	
	# not working
	uniq: ->
		u = {}
		a = []
		
		for val in @
			continue if u.hasOwnProperty val
			a.push val
			u[val] = 1
		
		return a
	
	
	###
	#
	# Nice-to-have manipulation functions
	#
	###
	
	addClass: ->
	removeClass: ->
	toggleClass: ->
	data: ->
	attr: ->
	
	append: ->
	prepend: ->
	remove: ->
	html: ->
	text: ->
	
	###
	
	events?
	ajax?
	pass html string to constructor? document fragment?
	
	###
	
	
# expose me, baby!
window.$ = window.$ or $
window.miniQuery = window.miniQuery or $