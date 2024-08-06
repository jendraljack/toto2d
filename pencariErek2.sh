#!/system/bin/sh
tap=$(dirname $(readlink /proc/$$/exe))
#echo "Current path: $tap"
fold="$(dirname $(realpath $0))"
#echo $fold
$tap/busybox echo -e "Pencari kode erek2 offline\n"
if [ ! -f "$fold/erek.txt" ]
then
echo "Tidak ada data erek2 di $fold"
kill -9 $$
fi

$tap/busybox echo -e "<< Inputkan kata kunci binatang/erek2 yg akan dicari nomor-nya?\nmisalnya: kuda,tikus dsb."
$tap/busybox echo -n ">> inputmu: "
read erek
case $erek in
"*");;
esac
$tap/busybox echo -n "$erek" > $fold/erek
duad="$(cat $fold/erek)"
echo "mencari $duad..."
if [ -z "$duad" ]
then
echo "memproses..."
sleep 2
echo "Kamu tidak input apapun.!"
kill -9 $$
fi
#echo $duad
#echo "$(basename $0)"
if [ ! -z "$duad" ]
then
$tap/busybox echo -e "#!/system/bin/sh" > $fold/02-$(basename $0)
$tap/busybox echo -e "if [ -z \"\$(cat $fold/erek.txt|grep -i $duad)\" ]\nthen\necho \"inputmu $duad tidak ada di data atau ejaanmu salah.\"\nfi\nif [ ! -z \"\$(cat $fold/erek.txt|grep -i $duad)\" ]\nthen\necho \"inputmu $duad: ditemukan\n\$(cat $fold/erek.txt|grep -i $duad)\"\nfi" >> $fold/02-$(basename $0)
fi

echo "memproses..."
sleep 3
sh $fold/02-$(basename $0)
$tap/busybox echo -e "\nPenulis kode: Supriyadi"
