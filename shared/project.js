
(function() {

    var _ = null;
    var async = null;
    var BaseEntity = null;
    var DBS = null;

    function Factory() {

        return BaseEntity.extend({
            defaults: {
                branches: null,
                name: '',
                tags: null,
                url: ''
            }
        }, {
            db: DBS.Projects
        });

    }

    if (typeof module !== 'undefined') {
        _ = require('underscore');
        async = require('async');
        BaseEntity = require('./base-entity');
        DBS = require('../lib/dbs');

        module.exports.Project = Factory();
    } else {
        angular.module('shared.entities').factory('ProjectEntity', ['_', 'async', 'BaseEntity', 'DBS', function(a, b, c, d) {
            _ = a;
            async = b;
            BaseEntity = c;
            DBS = d;

            return Factory();
        }]);
    }

})();
