#!/bin/bash

set -e

[ "$#" -eq 1 ] || echo "Usage build.sh <formula name>, e.g. ./buils.sh php71-ref" exit 1


if [ -z "$BINTRAY_API_KEY" ]; then echo "Please, set \$BINTRAY_API_KEY env variable"; exit 1; fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

TARGET_FORMULA=$1
TARGET_FORMULA_NAME=`echo $TARGET_FORMULA | tr @ :`

if [ ! -f "./Formula/${TARGET_FORMULA}.rb" ]; then echo "Target formula \"${TARGET_FORMULA}\" does not exists"; exit 1; fi


BINTRAY_ROOT_URL="https://dl.bintray.com/pinepain/bottles-devtools"
BINTRAY_USER=pinepain


brew fetch --retry  --build-bottle ./Formula/${TARGET_FORMULA}.rb
brew install --only-dependencies --build-bottle ./Formula/${TARGET_FORMULA}.rb
brew install --verbose --build-bottle ./Formula/${TARGET_FORMULA}.rb
brew audit --online ./Formula/${TARGET_FORMULA}.rb || true
brew bottle --json --root-url="${BINTRAY_ROOT_URL}" --force-core-tap ./Formula/${TARGET_FORMULA}.rb


export FORMULA_JSON=`ls | grep $TARGET_FORMULA | grep json`
export FORMULA_BOTTLE=`ls | grep $TARGET_FORMULA | grep tar.gz`
export FORMULA_VERSION=`echo ${FORMULA_JSON} | sed 's/.*-\([0-9\.][0-9\.]*\)\..*/\1/'`

brew bottle --merge --write --no-commit --root-url="${BINTRAY_ROOT_URL}" $FORMULA_JSON

git commit -m "Build and deploy ${TARGET_FORMULA} source package [skip ci]" ./Formula
git push

curl -T ${FORMULA_BOTTLE} -u${BINTRAY_USER}:${BINTRAY_API_KEY} https://api.bintray.com/content/pinepain/bottles-devtools/${TARGET_FORMULA_NAME}/${FORMULA_VERSION}/${FORMULA_BOTTLE}
curl -X POST -u${BINTRAY_USER}:${BINTRAY_API_KEY} https://api.bintray.com/content/pinepain/bottles-devtools/${TARGET_FORMULA_NAME}/${FORMULA_VERSION}/publish
