echo { pkgs, lib, ... }:
echo \[

while read line2
do
  line=$(echo $line2 | awk -F " " '{print $1}')
  finalurl=$(curl -w "%{url_effective}\n" -I -L -s -S https://clients2.google.com/service/update2/crx\?response\=redirect\&acceptformat\=crx2,crx3\&prodversion\=133\&x\=id%3D${line}%26installsource%3Dondemand%26uc -o /tmp/extensions.crx)
  hash=$(nix-prefetch-url $finalurl)
  hash=$(nix hash convert --to sri --hash-algo sha256 "$hash")
  echo "{id=\"$line\";crxPath=pkgs.fetchurl{url = \"$finalurl\";hash = \"$hash\";};}"
done < ./extensions-list

echo \]
