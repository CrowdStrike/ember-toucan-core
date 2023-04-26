#!/bin/bash

# COLORS
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
ENDCOLOR="\033[0m"

print_info() {
  echo -e "${CYAN} $1 ${ENDCOLOR}"
}

print_warning() {
  echo -e "${YELLOW}$1 ${ENDCOLOR}"
}

# VARIABLES
install_and_symlink=false
del_turbo_cache=false
del_node_modules_dist_and_tsc_cache=false

PS3='Please choose an option: '
options=(
  "Only install and symlink"
  "Please delete node_modules, dist, and typescript cache, and then install and symlink"
  "Please delete turbo cache, node modules, typescript cache, and install and symlink"
  "Quit"
)

select opt in "${options[@]}"
do
  case $opt in
    "Only install and symlink")
      print_info "choosing simple install"
      install_and_symlink=true
      break
    ;;
    "Please delete node_modules, dist, and typescript cache, and then install and symlink")
      del_node_modules_dist_and_tsc_cache=true
      install_and_symlink=true
      break
    ;;
    "Please delete turbo cache, node modules, typescript cache, and install and symlink")
      del_turbo_cache=true
      del_node_modules_dist_and_tsc_cache=true
      install_and_symlink=true
      break;
    ;;
    "Quit")
        print_info "Quitting"
        exit 0
        break
      ;;
  esac
done

print_info "running a git check"
if [[ $(git diff --stat) != '' ]]; then
  print_warning "You have changes not checked into git, please stash or commit them and try again"
  exit 1
else
  print_info "Git status is good, moving on to local setup..."
fi

if [[ "$del_turbo_cache" = true ]]
then
  print_info "deleting turbo cache..."
  find . -name ".turbo" -type d -prune -exec rm -rf "{}" \;
  rm -rf node_modules/.cache
fi

if [[ "$del_node_modules_dist_and_tsc_cache" = true ]]
then
  print_info "nukin' node_modules, declaration, dist directories, and tsc build cache"
  rm -rf node_modules/.cache;
  find . -name "node_modules" -type d -prune -exec rm -rf "{}" \;
  find . -name "declarations" -type d -prune -exec rm -rf "{}" \;
  find . -name "dist" -type d -prune -exec rm -rf "{}" \;
  find . -name "tsconfig.tsbuildinfo" -type f -exec rm -rf "{}" \;
fi

if [[ "$install_and_symlink" = true ]]
then
  pnpm i

  print_info "--installed node modules--"

  print_info "building ember-toucan-core"
  cd packages/ember-toucan-core
  pnpm build
  pnpm link .

  print_info "building ember-toucan-form"
  cd ../ember-toucan-form
  pnpm link @crowdstrike/ember-toucan-core
  pnpm build
  pnpm link .

  print_info "linking the docs app"
  cd ../../docs-app
  pnpm link @crowdstrike/ember-toucan-core
  pnpm link @crowdstrike/ember-toucan-form

  print_info "linking the test app"
  cd ../test-app
  pnpm link @crowdstrike/ember-toucan-core
  pnpm link @crowdstrike/ember-toucan-form

  pnpm i # this should link all of them
fi

print_info "Done"
echo "Please open a terminal in the packages/ember-toucan-core and pnpm start"
echo "Please open a new terminal in the root of the app and run pnpm start:docs"
echo "Please open another terminal in the test-app folder and run pnpm start"
echo "Please open a terminal in the packages/ember-toucan-forms and pnpm start"
echo "REMEMBER to not check in these changes to the package.json and pnpm-lock yaml files"
