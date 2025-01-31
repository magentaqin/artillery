'use strict';

const test = require('tape');
const runner = require('../../core').runner;
const { SSMS } = require('../../core/lib/ssms');

test('config variables', function (t) {
  const script = require('./scripts/config_variables.json');
  runner(script).then(function (ee) {
    ee.on('done', function (nr) {
      const report = SSMS.legacyReport(nr).report();
      t.assert(report.codes[200] > 0, 'there are 200s for /');
      t.assert(report.codes[404] > 0, 'there are 404s for /will/404');
      t.end();
    });
    ee.run();
  });
});
