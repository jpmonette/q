./scripts/ci/installDX.sh
npm install apexcov coveralls -g
echo y | sfdx plugins:install @mavens/sfdx-commands
