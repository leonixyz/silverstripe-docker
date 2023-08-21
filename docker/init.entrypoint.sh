#!/bin/sh

if [ -d composer.lock ]; then
    echo "Found composer.lock: nothing to do"
elif [ -f composer.json ]; then
    composer --no-cache install &&
    php vendor/silverstripe/framework/cli-script.php dev/build
else
    composer --no-cache create-project silverstripe/installer /app
cat <<EOF > app/_config/config.yml
SilverStripe\Admin\LeftAndMain:
    url_segment: 'admin'
SilverStripe\Control\Director:
    alternate_base_url: 'https://localhost'
EOF
fi

exit $?
