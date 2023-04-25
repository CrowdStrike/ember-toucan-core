echo "running a git check"
if [[ $(git diff --stat) != '' ]]; then
  echo 'You have changes not checked into git, please stash or commit them and try again'
  exit 1
else
  echo 'Git status is good, moving on to local setup...'
fi


echo "deleting turbo cache"
find . -name ".turbo" -type d -prune -exec rm -rf "{}" \;
rm -rf node_modules/.cache;

echo "nukin' node_modules, declaration, dist directories, and tsc build cache"
rm -rf node_modules/.cache;
find . -name "node_modules" -type d -prune -exec rm -rf "{}" \;
find . -name "declarations" -type d -prune -exec rm -rf "{}" \;
find . -name "dist" -type d -prune -exec rm -rf "{}" \;
find . -name "tsconfig.tsbuildinfo" -type f -exec rm -rf "{}" \;

pnpm i

echo "--installed node modules--"

echo "building ember-toucan-core"
cd packages/ember-toucan-core
pnpm build
pnpm link .

echo "building ember-toucan-form"
cd ../ember-toucan-form
pnpm link @crowdstrike/ember-toucan-core
pnpm build
pnpm link .

echo "linking the docs app"
cd ../../docs-app
pnpm link @crowdstrike/ember-toucan-core
pnpm link @crowdstrike/ember-toucan-form

echo "linking the test app"
cd ../test-app
pnpm link @crowdstrike/ember-toucan-core
pnpm link @crowdstrike/ember-toucan-form

pnpm i # this should link all of them

echo "Done"
echo "Please open a terminal in the packages/ember-toucan-core and pnpm start"
echo "Please open a new terminal in the root of the app and run pnpm start:docs"
echo "Please open another terminal in the test-app folder and run pnpm start"
echo "Please open a terminal in the packages/ember-toucan-forms and pnpm start"
echo "REMEMBER to not check in these changes to the package.json and pnpm-lock yaml files"
