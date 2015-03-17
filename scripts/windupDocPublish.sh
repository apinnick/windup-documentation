#!/bin/bash
if [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ]; then 

    echo "You must pass the following arguments on the command line:"
    echo "    Path to the local windup-documentation GitHub directory"
    echo "    Path to the local windup source GitHub directory"
    echo "    Name of the new beta version" 
    echo "For example:"
    echo "    scripts/windupDocPublish.sh ~/GitRepos/windup-documentation/ ~/GitRepos/windup/ 2.0.0.Beta8"
    exit
else
    echo  "Windup Documentation will be copied from here: " $1
    echo  "Windup Documentation will be copied to here:  " $2
fi
#################################
# Publish the Windup Guides
#################################

WINDUP_VERSION=$3
echo "Creating: " $WINDUP_VERSION

echo "Copying the HTML files from windup-documentation/html/"
cd $2
pwd
git fetch upstream
git checkout gh-pages
git reset --hard upstream/gh-pages 
cd docs/
pwd
echo Testing for existence of $WINDUP_VERSION
if [ ! -d  $WINDUP_VERSION ]; then
  echo Creating directory: $WINDUP_VERSION
  mkdir -p $WINDUP_VERSION/html/images
fi

cd $1
pwd
cp html/*.html $2/docs/$WINDUP_VERSION/html/
cp docs/*.css $2/docs/$WINDUP_VERSION/html/
cp docs/images/* $2/docs/$WINDUP_VERSION/html/images/

echo "Guides can be previewed here: "
echo "    User Guide: " file://$2/docs/$WINDUP_VERSION/html/WindupUserGuide.html
echo "    Rules Development Guide: " file://$2/docs/$WINDUP_VERSION/html/WindupRulesDevelopmentGuide.html
echo "    Core Development Guide: " file://$2/docs/$WINDUP_VERSION/html/WindupCoreDevelopmentGuide.html

cd $2
git add docs

git commit -m "Update the docs for release $3"

echo "The following are manual steps: "
echo "    git push origin HEAD"
echo "    (issue a pull and verify)"
echo "    git push upstream gh-pages"
echo "    firefox http://windup.github.io/windup/docs/$WINDUP_VERSION/html/WindupUserGuide.html"

# git push origin HEAD
## issue a pull and verify
# git push upstream gh-pages
#firefox http://windup.github.io/windup/docs/$WINDUP_VERSION/html/WindupUserGuide.html

cd $1
