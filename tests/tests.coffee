selectors = [
	'.intro'
	'#content'
	'*'
	'p'
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
	':not(p)'
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

QUnit.test "And they are the same Elements", ( assert ) ->
	
	for selector in selectors
		johanQueryResult = johanQuery(selector)
		jQueryResult = jQuery(selector)
		
		for result, i in johanQueryResult
			assert.ok johanQueryResult[i] is jQueryResult[i], "Both got the same <#{jQueryResult[i].tagName}>"


