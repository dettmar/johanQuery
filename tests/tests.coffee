selectors = [
	'.intro'
	'#content'
	'*'
	':not(p)'
	'html'
	'div, p'
	'div p'
	'div > p'
	'div + footer'
	'div ~ footer'
	'[target]'
	'[target=_blank]'
	'[title~=yes]'
	'[lang|=en]'
	'a[href^="https"]'
	'a[href$=".js"]'
	'a[href*="github"]'
	#'a:active'
	#'p::after'
	#'p::before'
	'input:checked'
	'input:disabled'
	'p:empty'
	'input:enabled'
	'p:first-child'
	#'p::first-letter'
	#'p::first-line'
	'p:first-of-type'
	#'input:focus'
	#'a:hover'
	'input:in-range'
	'input:invalid'
	'h2:lang(en)'
	'p:last-child'
	'p:last-of-type'
	'a:link'
	
	'p:nth-child(5)'
	'p:nth-last-child(2)'
	'p:nth-last-of-type(2)'
	'p:nth-of-type(2)'
	"ul:last-of-type"
	"li:nth-child(odd)"
	'p:only-of-type'
	'p:only-child'
	'input:optional'
	#'input:out-of-range'
	#'input:read-only'
	'input:read-write'
	'input:required'
	':root'
	
	#'::selection'
	'input:valid'
	#'a:visited'
	window
	document
]

QUnit.test "Scripts loaded", ( assert ) ->
	
	assert.ok(jQuery, "jQuery exists")
	assert.ok(johanQuery, "johanQuery exists")

QUnit.test "No conflict", ( assert ) ->
	
	assert.ok(jQuery("div") instanceof jQuery, "jQuery doesn't conflict")
	assert.ok(johanQuery("div") instanceof johanQuery, "jQuery doesn't conflict")
	
QUnit.test "Accepted selectors", ( assert ) ->
	
	for selector in selectors
		assert.ok(jQuery(selector).length, "johanQuery('#{selector}') should be accepted")

QUnit.test "Finds the same amount jQuery", ( assert ) ->
	
	for selector in selectors
		assert.equal johanQuery(selector).length,
			jQuery(selector).length,
			"johanQuery('#{selector}') selects same as jQuery (#{jQuery(selector).length} results)"

QUnit.test "And they are the same elements in the same order", ( assert ) ->
	
	for selector in selectors
		johanQueryResult = johanQuery(selector)
		jQueryResult = jQuery(selector)
		
		for result, i in johanQueryResult
			assert.ok johanQueryResult[i] is jQueryResult[i], "Both got the same <#{jQueryResult[i].tagName}> (#{selector})"


QUnit.test "Can manipulate classes", ( assert ) ->
	
	# TODO, separate in batches to not freeze the browser
	
	for selector in selectors[4..-10] # without window and document
		johanQuery(selector).each ->

			johanQueryElement = johanQuery(@)
			johanQueryElement.addClass "testing-class"			
			jQueryElement = jQuery(@)
			
			assert.ok jQueryElement.hasClass("testing-class"), "'#{selector}': Can add class to <#{@tagName}> "
			
			johanQueryElement.removeClass "testing-class"
			
			assert.ok not jQueryElement.hasClass("testing-class"), "'#{selector}': Can remove class to <#{@tagName}> "















