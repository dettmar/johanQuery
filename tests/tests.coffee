QUnit.test "Scripts loaded", ( assert ) ->
	
	assert.ok(jQuery, "jQuery exists")
	assert.ok(johanQuery, "johanQuery exists")

QUnit.test "No conflict", ( assert ) ->
	
	assert.ok(jQuery("div") instanceof jQuery, "jQuery doesn't conflict")
	assert.ok(johanQuery("div") instanceof johanQuery, "jQuery doesn't conflict")