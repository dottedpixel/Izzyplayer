for plist in build/IzzyPlayer.app/Contents/Info.plist TOOLS/osxbundle/IzzyPlayer.app/Contents/Info.plist; do
    sed -i '' 's/io\.mpv\./io.izzyplayer./g' "$plist"
    sed -i '' 's/mpv Custom Protocol/IzzyPlayer Custom Protocol/g' "$plist"
    sed -i '' 's/MPVBUNDLE/IZZYPLAYERBUNDLE/g' "$plist"
done
echo "Done"
