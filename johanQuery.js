
/*
 *
 * @description johanQuery - a tiny subset of jQuery
 * @class $ and johanQuery
 * @author J.Dettmar
 * @see https://github.com/dettmar/johanQuery
 * @license WTFPL
 *
 */

(function() {
  var johanQuery,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  johanQuery = (function(_super) {
    var _innerContent, _insertNodes, _manipulateClass;

    __extends(johanQuery, _super);

    function johanQuery(selector) {
      var result;
      if (selector instanceof johanQuery) {
        return selector;
      }
      if (!(this instanceof johanQuery)) {
        return new johanQuery(selector);
      }
      this.extend(this.__proto__, johanQuery.prototype);
      if (selector === window || selector === document) {
        this.push.call(this, selector);
      } else if (selector instanceof HTMLElement) {
        this.push.call(this, selector);
      } else if (selector instanceof Array) {
        this.push.apply(this, [].slice.call(selector));
      } else if (selector instanceof NodeList) {
        this.push.apply(this, [].slice.call(selector));
      } else if (this.isHTML(selector)) {
        result = this.parseHTML(selector);
        console.log("ishtml", selector, typeof result);
        if (selector === result) {
          this.push.apply(this, [].slice.call(document.querySelectorAll(selector)));
        } else {
          this.push.apply(this, [].slice.call(result));
        }
      } else if (selector instanceof Function) {
        if (document.readyState === "complete") {
          selector();
        } else {
          document.addEventListener("DOMContentLoaded", selector);
        }
      } else {
        this.push.apply(this, [].slice.call(document.querySelectorAll(selector)));
      }
      this.selector = selector;
      return this;
    }

    johanQuery.prototype.extend = function(obj, mixin) {
      var method, name;
      for (name in mixin) {
        method = mixin[name];
        if (name !== "extend") {
          obj[name] = method;
        }
      }
      return obj;
    };

    johanQuery.prototype.isHTML = function(string) {
      var regx;
      regx = /(<([^>]+)>)/ig;
      return regx.test(string);
    };


    /*
    	 *
    	 * Result manipulation methods
    	 *
     */

    johanQuery.prototype.slice = function() {
      return new johanQuery(johanQuery.__super__.slice.apply(this, arguments));
    };

    johanQuery.prototype.splice = function() {
      return new johanQuery(johanQuery.__super__.splice.apply(this, arguments));
    };

    johanQuery.prototype.reverse = function() {
      return new johanQuery(johanQuery.__super__.reverse.apply(this, arguments));
    };

    johanQuery.prototype.first = function() {
      return this.slice(0, 1);
    };

    johanQuery.prototype.last = function() {
      return this.slice(-1);
    };

    johanQuery.prototype.eq = function(num) {
      if (num == null) {
        num = 0;
      }
      return this.slice(num, num + 1);
    };

    johanQuery.prototype.get = function(num) {
      if (num == null) {
        num = 0;
      }
      return this[num];
    };

    johanQuery.prototype.each = function(callback) {
      var arr, element, i, _i, _len;
      arr = this;
      if (!(arr instanceof Array)) {
        arr = [].slice.call(arr);
      }
      for (i = _i = 0, _len = arr.length; _i < _len; i = ++_i) {
        element = arr[i];
        callback.call(element, i, element);
      }
      return this;
    };

    johanQuery.prototype.find = function(selector) {
      var result;
      result = [];
      this.each((function(_this) {
        return function(i, el) {
          return _this.each.call(el.querySelectorAll(selector), function() {
            return result.push(this);
          });
        };
      })(this));
      return new johanQuery(result);
    };

    johanQuery.prototype.map = function(callback) {
      var result;
      result = [];
      this.each(function(i, element) {
        var val;
        val = callback.call(element, i, element);
        if (val != null) {
          return result.push(val);
        }
      });
      return result;
    };

    johanQuery.prototype.add = function(content) {
      this.push.apply(this, new johanQuery(content));
      return this;
    };

    johanQuery.prototype.filter = function(callback) {
      var result;
      result = [];
      this.each(function(i, element) {
        if (callback.call(element, i, element)) {
          return result.push(this);
        }
      });
      return new johanQuery(result);
    };


    /*
    	 *
    	 * DOM traversal methods
    	 *
     */

    johanQuery.prototype.parent = function() {
      var result;
      result = [];
      this.each(function() {
        var _ref;
        if ((this.parentElement != null) && !(_ref = this.parentElement, __indexOf.call(result, _ref) >= 0)) {
          return result.push(this.parentElement);
        }
      });
      return new johanQuery(result);
    };

    johanQuery.prototype.children = function() {
      var result;
      result = [];
      this.each((function(_this) {
        return function(i, el) {
          return _this.each.call(el.children, function() {
            if (__indexOf.call(result, this) < 0) {
              return result.push(this);
            }
          });
        };
      })(this));
      return new johanQuery(result);
    };


    /*
    	 *
    	 * Class manipulation methods
    	 *
     */

    _manipulateClass = function(classNames, method) {
      return this.each(function() {
        return this.classList[method].apply(this.classList, classNames.split(" "));
      });
    };

    johanQuery.prototype.hasClass = function(classNames) {
      return this.get(0).classList.contains(classNames);
    };

    johanQuery.prototype.addClass = function(classNames) {
      return _manipulateClass.call(this, classNames, "add");
    };

    johanQuery.prototype.removeClass = function(classNames) {
      return _manipulateClass.call(this, classNames, "remove");
    };

    johanQuery.prototype.toggleClass = function(classNames) {
      return _manipulateClass.call(this, classNames, "toggle");
    };


    /*
    	 *
    	 * Attribute manipulation methods
    	 *
     */

    johanQuery.prototype.data = function(key, val) {
      return this.attr("data-" + key, val);
    };

    johanQuery.prototype.attr = function(key, val) {
      var attr;
      if (val == null) {
        attr = this.get(0).getAttribute(key);
        try {
          attr = JSON.parse(attr);
        } catch (_error) {}
        return attr;
      }
      val = typeof val === "string" ? val : JSON.stringify(val);
      return this.each(function() {
        return this.setAttribute(key, val);
      });
    };


    /*
    	 *
    	 * Node insertion methods
    	 *
     */

    _insertNodes = function(nodes, method) {
      if (typeof nodes === "string") {
        nodes = this.parseHTML(nodes);
      }
      if (!(nodes instanceof Array)) {
        nodes = [nodes];
      }
      return this.each((function(_this) {
        return function(i, el) {
          return _this.clone.call(nodes).each(function(j, node) {
            return el[method](node, el.firstChild);
          });
        };
      })(this));
    };

    johanQuery.prototype.append = function(nodes) {
      return _insertNodes.call(this, nodes, "appendChild");
    };

    johanQuery.prototype.prepend = function(nodes) {
      return _insertNodes.call(this, nodes, "insertBefore");
    };

    johanQuery.prototype.remove = function() {
      return this.each(function() {
        var _ref;
        return (_ref = this.parentElement) != null ? _ref.removeChild(this) : void 0;
      });
    };


    /*
    	 *
    	 * Node content methods
    	 *
     */

    _innerContent = function(content, method) {
      if (content == null) {
        return this.get(0)[method];
      }
      return this.each(function() {
        return this[method] = content;
      });
    };

    johanQuery.prototype.html = function(content) {
      return _innerContent.call(this, content, "innerHTML");
    };

    johanQuery.prototype.text = function(content) {
      return _innerContent.call(this, content, "innerText");
    };

    johanQuery.prototype.clone = function(deep) {
      if (deep == null) {
        deep = true;
      }
      return this.map(function() {
        if (this instanceof HTMLElement) {
          return this.cloneNode(deep);
        }
      });
    };

    johanQuery.prototype.parseHTML = function(htmlString) {
      var wrap;
      if (htmlString == null) {
        htmlString = "";
      }
      wrap = document.createElement('div');
      wrap.innerHTML = htmlString;
      return [].slice.call(wrap.childNodes);
    };


    /*
    	 *
    	 * Events
    	 *
     */

    johanQuery.prototype.on = function(eventName, callback) {
      return this.each(function() {
        return this["on" + eventName] = callback.bind(this);
      });
    };

    johanQuery.prototype.off = function(eventName) {
      return this.each(function() {
        return this["on" + eventName] = null;
      });
    };

    johanQuery.prototype.trigger = function(eventName, data) {
      return this.each(function() {
        return this.dispatchEvent(new CustomEvent(eventName, data));
      });
    };

    return johanQuery;

  })(Array);


  /*
   *
   *	Expose johanQuery and allow for advanced optimizations
   *
   */

  window["$"] = window["$"] || johanQuery;

  window["johanQuery"] = window["johanQuery"] || johanQuery;

}).call(this);

//# sourceMappingURL=johanQuery.js.map
