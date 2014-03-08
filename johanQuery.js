// Generated by CoffeeScript 1.6.3
/*
#
# @description miniQuery - a tiny subset of jQuery
# @class $ and miniQuery
# @author J.Dettmar
#
*/


(function() {
  var $,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

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
      } else if (this.isHTML(this.selector)) {
        result = this.parseHTML(this.selector);
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

    $.prototype.isHTML = function(string) {
      var regx;
      if (string == null) {
        string = "";
      }
      regx = /^(?:\s*(<[\w\W]+>)[^>]*|#([\w-]*))$/;
      return regx.test(string);
    };

    /*
    		#
    		# Result manipulation methods
    		#
    		# @method slice: -> inherited from Array
    		# @method splice: -> inherited from Array
    		# @method reverse: -> inherited from Array
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

    $.prototype.get = function(num) {
      if (num == null) {
        num = 0;
      }
      return this[num];
    };

    $.prototype.each = function(callback) {
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

    $.prototype.add = function() {};

    $.prototype.filter = function(callback) {
      var result;
      result = [];
      this.each(function(i, element) {
        if (callback.call(element, i, element)) {
          return result.push(this);
        }
      });
      return result;
    };

    /*
    		#
    		# DOM traversal methods
    		#
    */


    $.prototype.parent = function() {
      var result;
      result = [];
      this.each(function() {
        var _ref;
        if ((this.parentElement != null) && !(_ref = this.parentElement, __indexOf.call(result, _ref) >= 0)) {
          return result.push(this.parentElement);
        }
      });
      return result;
    };

    $.prototype.children = function() {
      var result,
        _this = this;
      result = [];
      this.each(function(i, el) {
        return _this.each.call(el.children, function() {
          if (!(__indexOf.call(result, this) >= 0)) {
            return result.push(this);
          }
        });
      });
      return result;
    };

    $.prototype.siblings = function() {};

    /*
    		#
    		# Class manipulation methods
    		#
    */


    $.prototype._manipulateClass = function(classNames, method) {
      return this.each(function() {
        return this.classList[method].apply(this.classList, classNames.split(" "));
      });
    };

    $.prototype.hasClass = function(classNames) {
      return this.get(0).classList.contains(classNames);
    };

    $.prototype.addClass = function(classNames) {
      return this._manipulateClass(classNames, "add");
    };

    $.prototype.removeClass = function(classNames) {
      return this._manipulateClass(classNames, "remove");
    };

    $.prototype.toggleClass = function(classNames) {
      return this._manipulateClass(classNames, "toggle");
    };

    /*
    		#
    		# Attribute manipulation methods
    		#
    */


    $.prototype.data = function(val, key) {
      return this.attr("data-" + val, key);
    };

    $.prototype.attr = function(val, key) {
      if (key == null) {
        return JSON.parse(this.get(0).getAttribute(val));
      }
      return this.each(function() {
        return this.setAttribute(val, JSON.stringify(key));
      });
    };

    /*
    		#
    		# Node insertion methods
    		#
    */


    $.prototype._insertNodes = function(nodes, method) {
      var _this = this;
      if (typeof nodes === "string") {
        nodes = this.parseHTML(nodes);
      }
      if (!(nodes instanceof Array)) {
        nodes = [nodes];
      }
      return this.each(function(i, el) {
        return _this.each.call(nodes, function(j, node) {
          if (method === "append") {
            return el.appendChild(_this.clone.call(node));
          } else {
            return el.insertBefore(_this.clone.call(node), el.firstChild);
          }
        });
      });
    };

    $.prototype.append = function(nodes) {
      return this._insertNodes(nodes, "append");
    };

    $.prototype.prepend = function(nodes) {
      return this._insertNodes(nodes, "prepend");
    };

    $.prototype.remove = function() {
      return this.each(function() {
        var _ref;
        return (_ref = this.parentElement) != null ? _ref.removeChild(this) : void 0;
      });
    };

    /*
    		#
    		# Node content methods
    		#
    */


    $.prototype.html = function(content) {
      if (content == null) {
        return this.get(0).innerHTML;
      }
      return this.each(function() {
        return this.innerHTML = content;
      });
    };

    $.prototype.text = function(content) {
      if (content == null) {
        return this.get(0).innerText;
      }
      return this.each(function() {
        return this.innerText = content;
      });
    };

    $.prototype.clone = function(deep) {
      if (deep == null) {
        deep = true;
      }
      if (this instanceof Array) {
        return this.map(function() {
          if (this instanceof HTMLElement) {
            return this.cloneNode(deep);
          }
        });
      }
      if (this instanceof HTMLElement) {
        return this.cloneNode(deep);
      }
      return this;
    };

    $.prototype.parseHTML = function(htmlString) {
      var wrap;
      if (htmlString == null) {
        htmlString = "";
      }
      wrap = document.createElement('div');
      wrap.innerHTML = htmlString;
      return [].slice.call(wrap.childNodes);
    };

    return $;

  })();

  /*
  	#
  	#	Expose $ and allow for advanced optimizations
  	#
  */


  window["$"] = window["$"] || $;

  window["miniQuery"] = window["miniQuery"] || $;

  $.prototype["extend"] = $.prototype.extend;

  $.prototype["isHTML"] = $.prototype.isHTML;

  $.prototype["first"] = $.prototype.first;

  $.prototype["last"] = $.prototype.last;

  $.prototype["eq"] = $.prototype.eq;

  $.prototype["get"] = $.prototype.get;

  $.prototype["each"] = $.prototype.each;

  $.prototype["find"] = $.prototype.find;

  $.prototype["map"] = $.prototype.map;

  $.prototype["add"] = $.prototype.map;

  $.prototype["filter"] = $.prototype.filter;

  $.prototype["parent"] = $.prototype.parent;

  $.prototype["children"] = $.prototype.children;

  $.prototype["siblings"] = $.prototype.siblings;

  $.prototype["hasClass"] = $.prototype.hasClass;

  $.prototype["addClass"] = $.prototype.addClass;

  $.prototype["removeClass"] = $.prototype.removeClass;

  $.prototype["toggleClass"] = $.prototype.toggleClass;

  $.prototype["attr"] = $.prototype.attr;

  $.prototype["data"] = $.prototype.data;

  $.prototype["append"] = $.prototype.append;

  $.prototype["prepend"] = $.prototype.prepend;

  $.prototype["remove"] = $.prototype.remove;

  $.prototype["html"] = $.prototype.html;

  $.prototype["text"] = $.prototype.text;

}).call(this);

/*
//@ sourceMappingURL=miniQuery.map
*/