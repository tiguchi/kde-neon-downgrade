#/bin/bash

echo "Updating package cache..."

sudo apt-get update

echo "Finding downgrade candidates..."

readarray -t NEWER_PACKAGES <<< "$(apt-show-versions | fgrep newer | cut -d ' ' -f1 | cut -d ':' -f1)"
PLAN=""

for PKG in "${NEWER_PACKAGES[@]}"; do
	VERSIONS=$(apt-cache policy "$PKG" | sed --expression='1,/\*\*\*/d')

	if [[ "$VERSIONS" =~ .*archive.neon.kde.org.*  ]]; then
		readarray -t VERSION_LINES <<< "$VERSIONS"
		DESIRED_VERSION=$(echo ${VERSION_LINES[1]} | cut -d ' ' -f1)
		echo "KDE Neon package $PKG will be downgraded to $DESIRED_VERSION"
		PLAN="$PLAN $PKG=$DESIRED_VERSION"
	fi
done

if [[ ! -z "$PLAN" ]]; then
	sudo apt-get install $PLAN
	echo "Downgrade finished. Please reboot your computer"
else
	echo "Nothing to do, you're all set!"
	exit 1
fi
