export SFDX_AUTOUPDATE_DISABLE=false
export SFDX_USE_GENERIC_UNIX_KEYCHAIN=true
export SFDX_DOMAIN_RETRY=300
export SFDX_DISABLE_APP_HUB=true
export SFDX_LOG_LEVEL=DEBUG

mkdir sfdx
wget -qO- https://developer.salesforce.com/media/salesforce-cli/sfdx-linux-amd64.tar.xz | tar xJ -C sfdx --strip-components 1
./scripts/ci/installDX.sh
echo force://$CLIENT_ID:$CLIENT_SECRET:$REFRESH_TOKEN@$INSTANCE_URL >.sfdx-url
sfdx force:auth:sfdxurl:store --setdefaultdevhubusername --sfdxurlfile ./.sfdx-url --setalias DefaultOrg
echo y | sfdx plugins:install @mavens/sfdx-commands
