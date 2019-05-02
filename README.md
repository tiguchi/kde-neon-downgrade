## KDE Neon Edition Switch Downgrader

Were you also curious (or desperate) to try the latest and greatest testing or internal development edition of KDE Neon, changed your mind, tried to switch back
to the "user" edition just to realize that all these brand new packages cannot be easily downgraded?

The newer packages linger around and can cause crashes and inconsistencies when mixed with older versions in the stable edition.

This script helps you with downgrading all KDE Neon packages to the latest version that is available in the enabled KDE Neon repository.

### How To Use?

#### 1. Switch your KDE Neon apt source back to the edition you want

This is something you need to do by hand first. Edit the file `/etc/apt/sources.list.d/neon.list` and switch to your desired edition.

For example:

Replace `http://archive.neon.kde.org/testing/` with `http://archive.neon.kde.org/user/

#### 2. Download and run the downgrade script

Run the following for downloading and executing the script in one go:

```
bash <(curl -s https://raw.githubusercontent.com/tiguchi/kde-neon-downgrade/master/kde-neon-downgrade.sh)
```

### How Does It Work?

1. The script creates a list of all packages that are newer than the latest known version in all active package repositories
2. For each of these packages it then determines the latest available version and whether these originate from the KDE Neon package repository
    - Manually installed newer packages that are not provided by the KDE Neon repository will be ignored
3. In the end it runs `apt-get install` for all of these KDE Neon packages, specifying the correct available version number
