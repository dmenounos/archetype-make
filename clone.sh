#!/bin/bash

set -e

# project id
PROJECT_ID=""

# output directory
OUT_DIR=".."

while getopts ":p:o:h" opt; do
	case $opt in
	"p")
		PROJECT_ID="$OPTARG"
		;;
	"o")
		OUT_DIR="$OPTARG"
		;;
	"h")
		echo "Usage $0 [OPTIONS]" >&2
		echo "OPTIONS" >&2
		echo "  -p Project id" >&2
		echo "  -o Output directory" >&2
		echo "EXAMPLE" >&2
		echo "$0 -p myproject -o .." >&2
		exit 1
		;;
	":")
		echo "Option -$OPTARG requires an argument" >&2
		exit 1
		;;
	"?")
		echo "Invalid option: -$OPTARG" >&2
		exit 1
		;;
	esac
done

if [ -z "$PROJECT_ID" ]; then
	$0 -h
	exit 1
fi

OUT_DIR=${OUT_DIR%/}
OUT_DIR="$(cd "$OUT_DIR" && pwd)"

# Confirm the creation of new project

echo -n "Create $OUT_DIR/$PROJECT_ID (y/n) "
read CONFIRM_CREATE

if [ $CONFIRM_CREATE != "y" ]; then
	exit 1
fi

# Confirm the deletion of existing project

if [ -d "$OUT_DIR/$PROJECT_ID" ]; then
	echo -n "Delete existing $OUT_DIR/$PROJECT_ID (y/n) "
	read CONFIRM_DELETE

	if [ $CONFIRM_DELETE != "y" ]; then
		exit 1
	fi

	rm -rf "$OUT_DIR/$PROJECT_ID"
fi

# Clone archetype to project

mkdir -p "$OUT_DIR/$PROJECT_ID"

cp -r "src"             "$OUT_DIR/$PROJECT_ID"
cp ".gitignore"         "$OUT_DIR/$PROJECT_ID"
cp "Makefile"           "$OUT_DIR/$PROJECT_ID"
