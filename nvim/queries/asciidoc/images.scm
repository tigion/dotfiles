
(macro
  (name) @name (#eq? @name "image")
  (target) @image.src (#match? @image.src "^[^{]")
) @image

(document_attribute
  (attribute_name) @name (#eq? @name "imageFile")
  (attribute_value) @image.src
) @image
