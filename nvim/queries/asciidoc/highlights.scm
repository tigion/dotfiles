;; extends

; document header

(document_title) @markup.heading.1.markdown

(document_authors) @string
(document_revision) @number

(document_attribute) @punctuation.bracket
(document_attribute (attribute_unset) @operator)
(document_attribute (attribute_name) @property)
(document_attribute (attribute_value) @string)

; document body

; Section
(section_level1 (section_header) @markup.heading.2.markdown)
(section_level2 (section_header) @markup.heading.3.markdown)
(section_level3 (section_header) @markup.heading.4.markdown)
(section_level4 (section_header) @markup.heading.5.markdown)
(section_level5 (section_header) @markup.heading.6.markdown)

; Title
(title) @markup.heading.1.markdown ;@title

; Macro
(macro) @punctuation.bracket ;@module
(macro (name) @keyword.function) ;@function.macro)
(macro (target) @markup.link)
(macro (attributes) @constant)

; Blocks
(example_block
  (example_block_marker_start) @markup.raw
  (example_block_marker_end) @markup.raw
)
(listing_block) @markup.raw

; Lists
(list (marker) @markup.list.markdown)

; Comments
(comment) @comment

; Other
(element_attributes) @character.special
(list_continuation_marker) @string.escape
