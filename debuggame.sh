rm game.love 
cp libdiscord-rpc.so /usr/lib32/
rm game.zip
zip -r game * 
mv game.zip game.love
love game.love 
rm game.love