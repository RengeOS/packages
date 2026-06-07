#!/bin/bash

set -e

repo="PKGBUILD"
target="x86_64"

echo "Clear up old $target..."
rm -rf ./$target/*

echo "Cloning repo $repo then build pkgs..."

if [ -d "./$repo" ]; then
    echo "Removing old $repo"
    rm -rf "./$repo"
fi

git clone https://github.com/RengeOS/$repo
cd ./$repo

echo "Building pkgs..."
packages=("rengeos-hooks"
          "rengeos-wallpapers"
          "rengeos-settings-gnome")

for pkg in "${packages[@]}"; do
    cd "./$pkg"

    echo "Building $pkg..."
    makepkg -s --noconfirm

    cp -r ./*.pkg.tar.zst "../../$target/"
    cd ..
done

cd .. # Return path back to root path -> `.`
rm -rf "./$repo" # Removing repo dir after build
echo "Repo adding..."

cd "$target"
repo-add rengeos-official.db.tar.zst *.pkg.tar.zst || exit 1
cd ..

echo "Done!"
