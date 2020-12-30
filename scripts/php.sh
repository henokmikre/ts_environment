#!/bin/bash

if brew list php@7.3; then
  echo $'\n'
  echo "Configuring PHP"
  echo $'\n'

  echo $'\n'
  echo "Installing PECL extensions (xdebug) for each version of PHP"
  echo $'\n'

  brew link --force php@7.3
  php -v
  pecl install -f xdebug

  echo $'\n'
  echo "Installing TS config for each version of PHP"
  echo $'\n'

  for VER in 7.3
  do
    $(brew --prefix gettext)/bin/envsubst < config/php-ts.ini > $(brew --prefix)/etc/php/$VER/conf.d/php-ts.ini
  done

  source scripts/cgr.sh

  echo $'\n'
  echo "Starting PHP."
  echo $'\n'

  brew services start php@7.3

  mkdir -pv ~/.drush
  cp -n config/drushrc.php ~/.drush/drushrc.php
fi
