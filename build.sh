#!/bin/bash
mkdir .build
ssg6 src .build "Erik Hedberg" https://erik.hedberg.at
if test -d "dest"; then
  mv dest .old
fi
mv .build dest && rm -rf .old