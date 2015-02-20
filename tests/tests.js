(function() {
  var selectors;

  selectors = ['.intro', '#content', '*', ':not(p)', 'html', 'div, p', 'div p', 'div > p', 'div + footer', 'div ~ footer', '[target]', '[target=_blank]', '[title~=yes]', '[lang|=en]', 'a[href^="https"]', 'a[href$=".js"]', 'a[href*="github"]', 'input:checked', 'input:disabled', 'p:empty', 'input:enabled', 'p:first-child', 'p:first-of-type', 'input:in-range', 'input:invalid', 'h2:lang(en)', 'p:last-child', 'p:last-of-type', 'a:link', 'p:nth-child(5)', 'p:nth-last-child(2)', 'p:nth-last-of-type(2)', 'p:nth-of-type(2)', "ul:last-of-type", "li:nth-child(odd)", 'p:only-of-type', 'p:only-child', 'input:optional', 'input:read-write', 'input:required', ':root', 'input:valid', window, document];

  QUnit.test("Scripts loaded", function(assert) {
    assert.ok(jQuery, "jQuery exists");
    return assert.ok(johanQuery, "johanQuery exists");
  });

  QUnit.test("No conflict", function(assert) {
    assert.ok(jQuery("div") instanceof jQuery, "jQuery doesn't conflict");
    return assert.ok(johanQuery("div") instanceof johanQuery, "jQuery doesn't conflict");
  });

  QUnit.test("Accepted selectors", function(assert) {
    var selector, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = selectors.length; _i < _len; _i++) {
      selector = selectors[_i];
      _results.push(assert.ok(jQuery(selector).length, "johanQuery('" + selector + "') should be accepted"));
    }
    return _results;
  });

  QUnit.test("Finds the same amount jQuery", function(assert) {
    var selector, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = selectors.length; _i < _len; _i++) {
      selector = selectors[_i];
      _results.push(assert.equal(johanQuery(selector).length, jQuery(selector).length, "johanQuery('" + selector + "') selects same as jQuery (" + (jQuery(selector).length) + " results)"));
    }
    return _results;
  });

  QUnit.test("And they are the same elements in the same order", function(assert) {
    var i, jQueryResult, johanQueryResult, result, selector, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = selectors.length; _i < _len; _i++) {
      selector = selectors[_i];
      johanQueryResult = johanQuery(selector);
      jQueryResult = jQuery(selector);
      _results.push((function() {
        var _j, _len1, _results1;
        _results1 = [];
        for (i = _j = 0, _len1 = johanQueryResult.length; _j < _len1; i = ++_j) {
          result = johanQueryResult[i];
          _results1.push(assert.ok(johanQueryResult[i] === jQueryResult[i], "Both got the same <" + jQueryResult[i].tagName + "> (" + selector + ")"));
        }
        return _results1;
      })());
    }
    return _results;
  });

  QUnit.test("Can manipulate classes", function(assert) {
    var selector, _i, _len, _ref, _results;
    _ref = selectors.slice(0, -2);
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      selector = _ref[_i];
      _results.push(johanQuery("section " + selector).each(function() {
        var jQueryElement, johanQueryElement;
        johanQueryElement = johanQuery(this);
        jQueryElement = jQuery(this);
        johanQueryElement.addClass("testing-class");
        assert.ok(jQueryElement.hasClass("testing-class"), "'" + selector + "': Can add class to <" + this.tagName + "> ");
        johanQueryElement.removeClass("testing-class");
        return assert.ok(!jQueryElement.hasClass("testing-class"), "'" + selector + "': Can remove class to <" + this.tagName + "> ");
      }));
    }
    return _results;
  });

  QUnit.test("Can manipulate attributes", function(assert) {
    var selector, _i, _len, _ref, _results;
    _ref = selectors.slice(0, -2);
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      selector = _ref[_i];
      _results.push(johanQuery("section " + selector).each(function() {
        var jQueryElement, johanQueryElement;
        johanQueryElement = johanQuery(this);
        jQueryElement = jQuery(this);
        johanQueryElement.attr("testing-attr", "testing-value");
        assert.equal(jQueryElement.attr("testing-attr"), "testing-value", "'" + selector + "': Can add class to <" + this.tagName + "> ");
        johanQueryElement.attr("testing-attr", "");
        return assert.equal(jQueryElement.attr("testing-attr"), "", "'" + selector + "': Can remove class to <" + this.tagName + "> ");
      }));
    }
    return _results;
  });

}).call(this);

//# sourceMappingURL=tests.js.map
