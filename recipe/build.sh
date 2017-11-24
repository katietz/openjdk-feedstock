#!/bin/bash -euo

if [[ $(uname) == Darwin ]]; then
  pushd Contents/Home
fi

chmod +x bin/*
chmod +x jre/bin/*
[[ -d $PREFIX/bin ]] || mkdir $PREFIX/bin
[[ -d $PREFIX/lib ]] || mkdir $PREFIX/lib
[[ -d $PREFIX/include ]] || mkdir $PREFIX/include
mv bin/* $PREFIX/bin/
mv lib/* $PREFIX/lib
mv include/* $PREFIX/include

if [[ -e jre/lib/jspawnhelper ]]; then
    chmod +x jre/lib/jspawnhelper
fi

if [[ $(uname -m) == x86_64 ]]; then
  _libarch=amd64
else
  _libarch=i386
fi

if [[ $(uname) == Linux ]]; then
    mv lib/${_libarch}/jli/*.so lib
    mv lib/${_libarch}/*.so lib
    rm -r lib/${_libarch}
    # libnio.so does not find this within jre/lib/amd64 subdirectory
    cp jre/lib/${_libarch}/libnet.so lib

    # include dejavu fonts to allow java to work even on minimal cloud images where these fonts are missing
    # (thanks to @chapmanb)
    pushd jre/lib/fonts
        mv dejavu-fonts-ttf-*/ttf/* .
        rm -rf dejavu-fonts-ttf-*
    popd
fi

mv jre $PREFIX/
if [[ -f src.zip ]]; then
  mv src.zip $PREFIX/jre/
fi

# ensure that JAVA_HOME is set correctly
mkdir -p $PREFIX/etc/conda/activate.d
mkdir -p $PREFIX/etc/conda/deactivate.d
cp $RECIPE_DIR/scripts/activate.sh $PREFIX/etc/conda/activate.d/java_home.sh
cp $RECIPE_DIR/scripts/deactivate.sh $PREFIX/etc/conda/deactivate.d/java_home.sh

if [[ $(uname) == Darwin ]]; then
  popd
fi
