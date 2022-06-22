#!/usr/bin/env bash
set -euo pipefail
trap 's=$?; echo >&2 "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

cd "$(dirname "$0")"
root=$(pwd)
env_header='# Only put stuff in here that you want to override default.env, no need to copy everything'

if [[ ! -e 'cooker' ]]; then
  # TEMP: Help existing developers running Cooker as its old name, API, to migrate to the new name
  if [ -d 'api' ]; then
    echo "=== MIGRATING YOUR API APPLICATION TO THE NEW NAME: COOKER ==="
    echo "Stopping all services as we're effectively about to remove one"
    docker-compose down 2> /dev/null || true
    echo "Renaming the directory 'api' to 'cooker'"
    mv api cooker
    echo "Changing remote URL of origin to ImmersiveLabsUkOrg/cooker"
    ( cd cooker && git remote set-url origin https://github.com/ImmersiveLabsUkOrg/cooker.git )
    if [[ -e 'docker-compose.override.yml' ]]; then
      echo "Replacing references to 'api' in your override file with 'cooker'. If you have issues this is likely the cause."
      echo "Your existing override file will be backed up to docker-compose.override.yaml.bak in case we mess up!"
      sed -i.bak -e 's/api/cooker/g'  -e 's/API/COOKER/g' docker-compose.override.yml
    fi
    if [[ -e 'cooker/.bundle/plugin/index' ]]; then
      echo "Replacing references to 'api' in your bundler plugin index due to https://github.com/rubygems/rubygems/issues/3340"
      sed -i.bak -e 's/api/cooker/g'  -e 's/API/COOKER/g' cooker/.bundle/plugin/index
    fi
    echo "=== COOKER MIGRATION COMPLETE ==="
  else
    git clone https://github.com/ImmersiveLabsUkOrg/cooker.git cooker
  fi
fi

if [[ ! -e 'mittens' ]]; then
  if [ -d 'main' ]; then
    echo "=== MIGRATING YOUR MAIN MONOREPO TO THE NEW NAME: MITTENS ==="
    echo "Stopping all services as we're effectively about to remove one"
    docker-compose down 2> /dev/null || true
    echo "Renaming the directory 'main' to 'mittens'"
    mv main mittens
    echo "Changing remote URL of origin to ImmersiveLabsUkOrg/mittens"
    ( cd mittens && git remote set-url origin https://github.com/ImmersiveLabsUkOrg/mittens.git )
    if [[ -e 'docker-compose.override.yml' ]]; then
      echo "Replacing references to 'main' in your override file with 'mittens'. If you have issues this is likely the cause."
      echo "Your existing override file will be backed up to docker-compose.override.yaml.bak in case we mess up!"
      sed -i.bak -e 's/main/mittens/g'  -e 's/MAIN/MITTENS/g' docker-compose.override.yml
    fi
    echo "=== MITTENS MIGRATION COMPLETE ==="
  else
    git clone https://github.com/ImmersiveLabsUkOrg/mittens.git mittens
  fi
fi

if [[ ! -e 'machine-pollers' ]]; then
  git clone https://github.com/ImmersiveLabsUkOrg/machine-pollers.git machine-pollers
fi

if [[ ! -e 'data-engineering' ]]; then
  git clone https://github.com/ImmersiveLabsUkOrg/data-engineering.git data-engineering
fi

if [[ ! -e 'cyber_crisis_simulator' ]]; then
  git clone https://github.com/ImmersiveLabsUkOrg/cyber-crisis-simulator.git cyber_crisis_simulator
fi

if [[ ! -e 'games_server' ]]; then
  git clone https://github.com/ImmersiveLabsUkOrg/WOPR.git games_server
fi

if [[ ! -e 'testcafe' ]]; then
  git clone https://github.com/ImmersiveLabsUkOrg/testcafe.git testcafe
  echo '# Only put stuff in here that you want to override env.defaults, no need to copy everything' > testcafe/.env
fi

if [[ ! -e 'mittens/packages/main/.env' ]]; then
  cp mittens/packages/main/.env.development mittens/packages/main/.env
fi

if [[ ! -e 'cooker/.env' ]]; then
  echo $env_header > cooker/.env
fi

if [[ ! -e 'cyber_crisis_simulator/.env' ]]; then
  echo $env_header > cyber_crisis_simulator/.env
fi

if [[ ! -e 'data-engineering/.env' ]]; then
  echo $env_header > data-engineering/.env
fi

if [[ ! -e 'mittens/.env' ]]; then
  echo $env_header > mittens/.env
fi

if [[ ! -e 'docker-ngrok-content/.env' ]]; then
  cp docker-ngrok-content/env_example docker-ngrok-content/.env
fi

# run config for githooks
cd mittens/
git config core.hooksPath .githooks

case ":$PATH:" in
  # Not checking the full path because you might have added it as ~/... instead of /home/abc/...
  *platform-wrapper/bin:*) true;;
  *) echo "Please ensure that $root/bin is in your shell's \$PATH" ;;
esac
