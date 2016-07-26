projectName=$1
echo Initialling React Native project $projectName with version: $2

rninit init $projectName --source react-native@$2

rnxRoot=${BASH_SOURCE[0]%/*}/../

cd $projectName

cp -r $rnxRoot/template/ ./ 

jq -r '.version="1.0.0" \
    | .main="src/module.js" \
    | .scripts.build="rnx build" \
    | .scripts.release="rnx release" \
    | .scripts.lint="eslint test src" \
    | .scripts.test="rnx test" \
    | .config.appName="$projectName" \
    | .config.iphoneModel="iPhone 6s" ' package.json > tmp.json && mv tmp.json package.json

npm install react-native-extended-cli enzyme proxyquire react-dom react-native-mock --save-dev

#TODO: Add this to package.json
# "babel": {
#     "env": {
#       "specs": {
#         "presets": [
#           "es2015",
#           "react",
#           "stage-0"
#         ],
#         "retainLines": true
#       }
#     }
#   }