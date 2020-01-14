# def2fgd distributions

Making [def2fgd](https://github.com/FreeSlave/def2fgd) packages for different distros.

Packages are published on [OBS](https://software.opensuse.org//download.html?project=home%3AFreeSlave&package=def2fgd).

## Make deb package

First make an orig archive. Assuming [def2fgd](https://github.com/FreeSlave/def2fgd) is cloned into the same directory as this repository is:

```
    ./make_deb_orig.sh
```

Then you have two options of building a package.

### First: Using debuild

```
    sudo apt-get install build-essential devscripts debhelper
    (cd deb/def2fgd && debuild -uc -us)
```

### Second: Using pbuilder

Create pbuilder chroot:

```
    sudo apt-get install pbuilder

    DISTRO=wheezy # or another distribution
    ARCH=amd64 # or i386
    BASETGZPATH=/var/cache/pbuilder
    BASETGZ="$BASETGZPATH/$DISTRO-$ARCH.tgz" # form a path to archived chroot, you can choose a different path
    sudo pbuilder create --basetgz "$BASETGZ" --distribution $DISTRO --architecture $ARCH
```

If chroot is already created you can update it:

```
    sudo pbuilder --update --basetgz "$BASETGZ" --distribution $DISTRO --architecture $ARCH --override-config
```

Make a package:

```
    ./make_deb_with_pbuilder.sh "$BASETGZ"
```

## Make rpm package

```
    ./make_rpm_orig.sh
```

Build using mock:

```
    sudo apt-get install mock # also can be installed on Debian
    sudo groupadd mock # if group does not exist yet
    sudo usermod -a -G mock $USER # allow starting mock as regular user

    # Re-login to system to apply changes to user groups

    CONFIGURATION=epel-6-x86_64
    VENDOR=el6
    VERSION="$(cat ../def2fgd/version)"
    REVISION=2
    mkdir -p rpm/SRPMS rpm/RPMS
    mock --resultdir="rpm/SRPMS" -r "$CONFIGURATION" --buildsrpm --spec "rpm/SPECS/def2fgd.spec" --sources "rpm/SOURCES"
    mock --resultdir="rpm/RPMS" -r "$CONFIGURATION" "rpm/SRPMS/def2fgd-$VERSION-$REVISION.$VENDOR.src.rpm"
```

