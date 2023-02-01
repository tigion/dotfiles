#!/bin/bash

check() {
  if ! eval "$1" 2> /dev/null; then echo "! '$2' is not installed or found"; fi
}

echo "Ruby:"
check "ruby -v" "ruby"

echo "Java:"
check "java --version" "java"

echo "Asciidoctor:"
check "asciidoctor -v" "asciidoctor"
check "asciidoctor-pdf -v" "asciidoctor-pdf"

echo "Graphviz (dot):"
check "dot -V" "dot"

echo "RubyGems:"
check "gem list | grep asciidoctor" "asciidoctor"
check "gem list | grep asciidoctor-pdf" "asciidoctor-pdf"
check "gem list | grep asciidoctor-diagram" "asciidoctor-diagram"
check "gem list | grep rouge" "rouge"
check "gem list | grep text-hyphen" "text-hyphen"
