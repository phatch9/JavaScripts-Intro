// NOTE: This library uses non-standard JS features (although widely supported).
// Specifically, it uses Function.name.

function any(v) {
    return true;
    }
    
    function isNumber(v) {
    return !Number.isNaN(v) && typeof v === 'number';
    }
    isNumber.expected = "number";
    
    function isBoolean(v) {
        return typeof v === 'boolean';
    }
    isBoolean.expected = "boolean";
    
    function isDefined(v) {
        return v !== null && v !== undefined;
    }
    isDefined.expected = "defined";
    
    function isString(v) {
        return typeof v === 'string' || v instanceof String;
    }
    isString.expected = "string";
    
    function isNegative(v) {
        return typeof v === 'number' && v < 0;
    }
    isNegative.expected = "negative number";
    
    function isPositive(v) {
        return typeof v === 'number' && v > 0;
    }
    isPositive.expected = "positive number";
    
    // Combinators:
    function and() {
        let args = Array.prototype.slice.call(arguments);
        let cont = function(v) {
        for (let i in args) {
            if (!args[i].call(this, v)) {
            return false;
            }
        }
        return true;
        };
        cont.expected = expect(args[0]);
        for (let i = 1; i < args.length; i++) {
        cont.expected += " and " + expect(args[i]);
        }
        return cont;
    }
    // OR contract combinator
    function or() {
        let args = Array.prototype.slice.call(arguments);
        let cont = function(v) {
        for (let i in args) {
            if (args[i].call(this, v)) {
            return true;
            }
        }
        return false;
        };
        cont.expected = expect(args[0]);
        for (let i = 1; i < args.length; i++) {
        cont.expected += " or " + expect(args[i]);
        }
        return cont;
    }
    // NOT contract combinator
    function not(c) {
        let cont = function(v) {
        return !c.call(this, v);
        };
        cont.expected = "not " + expect(c);
        return cont;
    }
    
    function expect(f) {
        if (f.expected) {
        return f.expected;
        }
        if (f.name) {
        return f.name;
        }
        return "ANONYMOUS CONTRACT";
    }
    
    function contract(preList, post, f) {
        return new Proxy(f, {
            apply: function(target, thisArg, argumentsList) {
            for (let i = 0; i < preList.length; i++) {
                const contractFn = preList[i];
                const arg = argumentsList[i];
                if (!contractFn(arg)) {
                    throw new Error(
                        `Contract violation: expected argument ${i + 1} to be ${expect(contractFn)}, but got ${JSON.stringify(arg)}. Blame -> caller`
                    );
                    }
                }
            const result = target.apply(thisArg, argumentsList);
                if (!post(result)) {
                throw new Error(
                    `Contract violation: expected return value to be ${expect(post)}, but got ${JSON.stringify(result)}. Blame -> library`
                );
                }
                return result;
            }
        });
    }
    
    module.exports = {
        contract: contract,
        any: any,
        isBoolean: isBoolean,
        isDefined: isDefined,
        isNumber: isNumber,
        isPositive: isPositive,
        isNegative: isNegative,
        isInteger: Number.isInteger,
        isString: isString,
        and: and,
        or: or,
        not: not,
    };
    