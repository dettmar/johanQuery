// Generated by CoffeeScript 1.6.3
/*
#
# @description miniQuery - a tiny subset of jQuery
# @class $ and miniQuery
# @author J.Dettmar
#
*/


(function() {
  var $;

  $ = (function() {
    function $(selector) {
      var result;
      if (!(this instanceof $)) {
        return new $(selector);
      }
      this.selector = selector;
      if (this.selector === window || this.selector === document) {
        result = [this.selector];
      } else if (this.selector instanceof HTMLElement) {
        result = [this.selector];
      } else if (this.selector instanceof NodeList) {
        result = [].slice.call(this.selector);
      } else {
        result = document.querySelectorAll(this.selector);
        result = [].slice.call(result);
      }
      this.extend(result.__proto__, $.prototype);
      return result;
    }

    $.prototype.extend = function(obj, mixin) {
      var method, name;
      for (name in mixin) {
        method = mixin[name];
        if (name !== "extend") {
          obj[name] = method;
        }
      }
      return obj;
    };

    /*
    	#
    	# Result manipulation methods
    	#
    */


    $.prototype.first = function() {
      return this.slice(0, 1);
    };

    $.prototype.last = function() {
      return this.slice(-1);
    };

    $.prototype.eq = function(num) {
      if (num == null) {
        num = 0;
      }
      return this.slice(num, num + 1);
    };

    $.prototype.each = function(callback) {
      var element, i, _i, _len;
      for (i = _i = 0, _len = this.length; _i < _len; i = ++_i) {
        element = this[i];
        callback.call(element, i, element);
      }
      return this;
    };

    $.prototype.find = function(selector) {
      var result,
        _this = this;
      result = [];
      this.each(function(i, el) {
        return _this.each.call(el.querySelectorAll(selector), function() {
          return result.push(this);
        });
      });
      return result;
    };

    $.prototype.map = function(callback) {
      var result,
        _this = this;
      result = [];
      this.each(function(i, element) {
        return result.push(callback.call(element, i, element));
      });
      return result;
    };

    /*
    	#
    	# Nice-to-have traversal functions
    	#
    */


    $.prototype.parent = function() {};

    $.prototype.children = function() {};

    $.prototype.siblings = function() {};

    $.prototype.add = function() {};

    $.prototype.filter = function() {};

    $.prototype.uniq = function() {
      var a, u, val, _i, _len;
      u = {};
      a = [];
      for (_i = 0, _len = this.length; _i < _len; _i++) {
        val = this[_i];
        if (u.hasOwnProperty(val)) {
          continue;
        }
        a.push(val);
        u[val] = 1;
      }
      return a;
    };

    /*
    	#
    	# Nice-to-have manipulation functions
    	#
    */


    $.prototype.addClass = function() {};

    $.prototype.removeClass = function() {};

    $.prototype.toggleClass = function() {};

    $.prototype.data = function() {};

    $.prototype.attr = function() {};

    $.prototype.append = function() {};

    $.prototype.prepend = function() {};

    $.prototype.remove = function() {};

    $.prototype.html = function() {};

    $.prototype.text = function() {};

    /*
    	
    	events?
    	ajax?
    	pass html string to constructor? document fragment?
    */


    return $;

  })();

  window.$ = window.$ || $;

  window.miniQuery = window.miniQuery || $;

}).call(this);
