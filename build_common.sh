#!/bin/sh

BUILD_TYPE=$1
PKG_NAME=$2
PROJECT_NAME=$3
R_JAVA_COPY_TO_FOLDER=$4
PKG_NAME_PATH=`echo "$PKG_NAME" | sed 's/\./\//g'`

R_JAVA_FILE_PATH="build/generated/source/r/debug/$PKG_NAME_PATH/R.java"
VALUE_FOLDER_PATH="res/values"
RES_TOOL_PATH="tools/ResourceTool.jar"
OUT_R_JAVA_FOLDER="gen/$PKG_NAME_PATH"
OUT_R_JAVA_FILE_PATH="$OUT_R_JAVA_FOLDER/R.java"
OUT_FOLDER="out"
APK_NAME="bin/$PROJECT_NAME-$BUILD_TYPE.apk"
FINAL_APK_NAME="$PROJECT_NAME.zip"

if [ -d "$OUT_FOLDER" ] 
then
	rm -rf $OUT_FOLDER
fi

mkdir -p $OUT_FOLDER/$PKG_NAME_PATH

java -jar $RES_TOOL_PATH $R_JAVA_FILE_PATH $VALUE_FOLDER_PATH 0

ant clean
ant $BUILD_TYPE

mkdir -p $R_JAVA_COPY_TO_FOLDER/$PKG_NAME_PATH

cp -f $OUT_R_JAVA_FILE_PATH "$OUT_FOLDER/$PKG_NAME_PATH/R.java"
cp -f $APK_NAME	"$OUT_FOLDER/$FINAL_APK_NAME"

cp -f $OUT_R_JAVA_FILE_PATH "$R_JAVA_COPY_TO_FOLDER/$PKG_NAME_PATH/R.java"


adb push "$OUT_FOLDER/$FINAL_APK_NAME" "//sdcard/$FINAL_APK_NAME"