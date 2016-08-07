#!/bin/bash
#
# A script to create a self-contained bundle that can
# be put into /Applications
#
. ./config.sh
APP_DIR="${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}"
wc=`pwd | wc -c`
echo Bundling `echo "${APP_DIR}" | cut -c${wc}- | sed 's|^[^/]*/||'`
APP_CONTENTS="${APP_DIR}/Contents"
MACOS_BIN="${APP_CONTENTS}/MacOS"
FRAMEWORKS_FOLDER_PATH="${APP_CONTENTS}/Frameworks"
mkdir -p "${MACOS_BIN}"
cp -p "${BUILD_BIN}/${Mod}" "${MACOS_BIN}"
rm -rf "${APP_CONTENTS}/Resources"
cp -pR "${RESOURCES_DIR}" "${APP_CONTENTS}"
echo 'APPL????' > ${APP_CONTENTS}/PkgInfo
sed < "${RESOURCES_DIR}/Info.plist" > "${APP_CONTENTS}/Info.plist"	\
	-e 's/\$.EXECUTABLE_NAME./'"${EXECUTABLE_NAME}.sh/g"	\
	-e 's/\$.PRODUCT_NAME./'"${PRODUCT_NAME}/g"		\
	-e 's/\$.MACOSX_DEPLOYMENT_TARGET./'"${MACOSX_DEPLOYMENT_TARGET}/g"\
	-e 's/\$.PRODUCT_BUNDLE_IDENTIFIER./'"${PRODUCT_BUNDLE_IDENTIFIER}/g"
cat > "${MACOS_BIN}/${EXECUTABLE_NAME}.sh" << EOF
#!/bin/bash
#
# Gtk Wrapper to set up environment
#
if test "x\$GTK_DEBUG_LAUNCHER" != x; then
    set -x
fi

if test "x\$GTK_DEBUG_GDB" != x; then
    EXEC="lldb --"
else
    EXEC=exec
fi
name=$EXECUTABLE_NAME
tmp="\$0"
tmp=\`dirname "\$tmp"\`
tmp=\`dirname "\$tmp"\`
tmp=\`dirname "\$tmp"\`
bundle=\`cd "\$tmp" && pwd\`
bundle_contents="\$bundle"/Contents
bundle_res="\$bundle_contents"/Resources
bundle_frm="\$bundle_contents"/Frameworks
bundle_lib="\$bundle_res"/lib
bundle_bin="\$bundle_res"/bin
bundle_data="\$bundle_res"/share
bundle_etc="\$bundle_res"/etc

export DYLD_LIBRARY_PATH="\${bundle_frm}:\$bundle_lib"
export XDG_CONFIG_DIRS="\$bundle_etc"/xdg
export XDG_DATA_DIRS="\$bundle_data"
export GTK_DATA_PREFIX="\$bundle_res"
export GTK_EXE_PREFIX="\$bundle_res"
export GTK_PATH="\$bundle_res"
export PATH="\$bundle_contents/MacOS:\$bundle_bin:\$PATH"

# Strip out the argument added by the OS.
if /bin/expr "x\$1" : '^x-psn_' > /dev/null; then
 shift 1
fi

\$EXEC "\$bundle_contents/MacOS/\$name" "\$@" \$EXTRA_ARGS
EOF
chmod +x "${MACOS_BIN}/${EXECUTABLE_NAME}.sh"
cd "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/MacOS"
LOG=/tmp/${Mod}-$$.log
TMPX=/tmp/${Mod}-xfiles.$$
SRTX=/tmp/${Mod}-srt.$$
mkdir -p ../Frameworks
rm -f ${TMPX}
for executable in ${PRODUCT_NAME} ; do
  echo "`pwd`/$executable" >> ${TMPX}
  for lib in `otool -L ${executable} | grep usr.local.Cellar | cut -f2 | cut -d' ' -f1` ; do
    dst=`echo $lib | sed -e 's|/usr/local/.*lib/|@executable_path/../Frameworks/|'`
    full=`echo $dst | sed -e "s|@executable_path|${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/MacOS|"`
    echo "${lib}|${dst}|${full}" >> ${TMPX}
    echo cp -p "${lib}" "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/Frameworks" >> ${LOG}
    cp -p "${lib}" "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/Frameworks" 2>/dev/null
    for sublib in `otool -L ${lib} 2>/dev/null | grep usr.local.Cellar | cut -f2 | cut -d' ' -f1` ; do
      dst=`echo $sublib | sed -e 's|/usr/local/.*lib/|@executable_path/../Frameworks/|'`
      full=`echo $dst | sed -e "s|@executable_path|${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/MacOS|"`
      echo "${sublib}|${dst}|${full}" >> ${TMPX}
      echo cp -p "${sublib}" "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/Frameworks" >> ${LOG}
      cp -p "${sublib}" "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/Frameworks" 2>/dev/null
      for ssublib in `otool -L ${sublib} 2>/dev/null | grep usr.local.Cellar | cut -f2 | cut -d' ' -f1` ; do
        dst=`echo $ssublib | sed -e 's|/usr/local/.*lib/|@executable_path/../Frameworks/|'`
        full=`echo $dst | sed -e "s|@executable_path|${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/MacOS|"`
        echo "${ssublib}|${dst}|${full}" >> ${TMPX}
        echo cp -p "${ssublib}" "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/Frameworks" >> ${LOG}
        cp -p "${ssublib}" "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/Frameworks" 2>/dev/null
      done
    done
  done
  for lib in `otool -L ${executable} | grep usr.local | cut -f2 | cut -d' ' -f1` ; do
    dst=`echo $lib | sed -e 's|/usr/local/.*lib/|@executable_path/../Frameworks/|'`
    full=`echo $dst | sed -e "s|@executable_path|${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/MacOS|"`
    echo "${lib}|${dst}|${full}" >> ${TMPX}
    echo cp -p "${lib}" "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/Frameworks" >> ${LOG}
    cp -p "${lib}" "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/Frameworks" 2>/dev/null
    for sublib in `otool -L ${lib} 2>/dev/null | grep usr.local | cut -f2 | cut -d' ' -f1` ; do
      dst=`echo $sublib | sed -e 's|/usr/local/.*lib/|@executable_path/../Frameworks/|'`
      full=`echo $dst | sed -e "s|@executable_path|${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/MacOS|"`
      echo "${sublib}|${dst}|${full}" >> ${TMPX}
      echo cp -p "${sublib}" "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/Frameworks" >> ${LOG}
      cp -p "${sublib}" "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/Frameworks" 2>/dev/null
      for ssublib in `otool -L ${sublib} 2>/dev/null | grep usr.local | cut -f2 | cut -d' ' -f1` ; do
        dst=`echo $ssublib | sed -e 's|/usr/local/.*lib/|@executable_path/../Frameworks/|'`
        full=`echo $dst | sed -e "s|@executable_path|${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/MacOS|"`
        echo "${ssublib}|${dst}|${full}" >> ${TMPX}
        echo cp -p "${ssublib}" "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/Frameworks" >> ${LOG}
        cp -p "${ssublib}" "${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/Contents/Frameworks" 2>/dev/null
      done
    done
  done
done
sort -u ${TMPX} >${SRTX}
for line in `cat ${SRTX}` ; do
  full=`echo $line | cut -d'|' -f3`
  if [ -e "$full" ] ; then
    for lnk in `cat ${SRTX}` ; do
      obj=`echo $lnk | cut -d'|' -f1`
      dst=`echo $lnk | cut -d'|' -f2`
      chmod +w "$full"
      install_name_tool -change "$obj" "$dst" "$full"
      #chmod -w "$full"
    done
  else
    echo "'$full' is missing" >> ${LOG}
  fi
done
rm -f ${TMPX}
rm -f ${SRTX}
printenv | sort >> ${LOG}
