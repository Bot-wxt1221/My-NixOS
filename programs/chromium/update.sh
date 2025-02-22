#! /usr/bin/env nix-shell
#! nix-shell -i bash -p jq curl wget unzip

echo { pkgs, lib, ... }:
echo \[

while read line2
do
  line=$(echo $line2 | awk -F " " '{print $1}')
  finalurl=$(curl -w "%{url_effective}\n" -I -L -s -S https://clients2.google.com/service/update2/crx\?response\=redirect\&acceptformat\=crx2,crx3\&prodversion\=133\&x\=id%3D${line}%26installsource%3Dondemand%26uc -o /tmp/extensions.crx)
  wget -O /tmp/extensions.zip $finalurl > /dev/null
  hash=$(sha256sum /tmp/extensions.zip| cut -d" " -f1)
  hash=$(nix hash to-sri --type sha256 "$hash")
  rm -rf /tmp/extensions > /dev/null
  unzip /tmp/extensions.zip -d /tmp/extensions > /dev/null
  version=$(jq -r ".version" < /tmp/extensions/manifest.json)
  echo "{id=\"$line\";crxPath=pkgs.fetchurl{url = \"$finalurl\";name = \"$line.crx\";hash = \"$hash\";};version = \"$version\";}"
done < ./extensions-list

echo \]
