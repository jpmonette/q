SFDX_IMPROVED_CODE_COVERAGE=true

sfdx force:apex:test:run --codecoverage --testlevel=RunLocalTests --resultformat=human --outputdir=coverage -u $SFDX_ALIAS --wait=30
sfdx mavens:ci:lcov
cat ./coverage/lcov.info | coveralls
