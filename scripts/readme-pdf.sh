#!/bin/sh
# Builds PDFs of the documents with pandoc and Prince, using
# scripts/print.css, for reading offline. The PDFs are git-ignored: build
# them when you want them.
#
#   scripts/readme-pdf.sh                          # every document, each PDF beside it
#   scripts/readme-pdf.sh thoughts/PROCESS.md      # thoughts/PROCESS.pdf
#   scripts/readme-pdf.sh PRACTICE.md out.pdf
set -eu

if [ $# -gt 2 ]; then
	echo "usage: $0 [FILE.md [out.pdf]]" >&2
	exit 2
fi

# The second argument is written over, so a document named there by
# mistake, as in "readme-pdf.sh ROADMAP.md docs/REFERENCE.md", would be
# lost: only a .pdf is written.
case ${2:-x.pdf} in
*.pdf) ;;
*)
	echo "$0: $2: the output must be a .pdf" >&2
	echo "usage: $0 [FILE.md [out.pdf]]" >&2
	exit 2
	;;
esac

root=$(cd "$(dirname "$0")/.." && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "${tmp:?}"' EXIT

# build makes one PDF: build FILE.md OUT.pdf
build() {
	title=$(sed -n 's/^# //p' "$1" | head -n 1)
	html=$tmp/page.html
	mkdir -p "$(dirname "$2")"
	# print.css is linked from the page, after pandoc's own styles, so that it
	# takes precedence over them (a style sheet given to prince --style wouldn't).
	pandoc "$1" --from gfm --standalone --metadata pagetitle="${title:-README}" \
		--css "file://$root/scripts/print.css" --output "$html"
	prince "$html" --no-warn-css --output "$2"
	echo "$2"
}

if [ $# -eq 0 ]; then
	for doc in "$root"/README.md "$root"/PRACTICE.md "$root"/thoughts/*.md; do
		build "$doc" "${doc%.md}.pdf"
	done
else
	build "$1" "${2:-${1%.md}.pdf}"
fi
