import jsdom from "jsdom"
import { DOMSerializer } from "prosemirror-model"

import * as schemas from "bainistighn/journal-schema"

//
// Exported functions
// -------------------------------------------------------------------------------------------------

export default function extract(doc, doc_schema) {
  // Create a virtual DOM environment, using JSDOM and then have ProseMirror serialize the document
  // and return a virtual `DocumentFragment` object.
  const { window } = new jsdom.JSDOM()
  const schema = schemas[doc_schema]
  const node = schema.nodeFromJSON(doc)
  const dom = DOMSerializer.fromSchema(schema).serializeFragment(node.content, {
    document: window.document,
  })

  const template = window.document.createElement("div")
  for (let i = 0; i < dom.childNodes.length; i++) {
    const child = dom.childNodes[i].cloneNode(true)
    if (child) template.appendChild(child)
    if (i < dom.childNodes.length - 1) template.appendChild(window.document.createTextNode(" "))
  }

  return {
    content_html: template.innerHTML,
    content_text: template.textContent,
  }
}

//
// Private functions
// -------------------------------------------------------------------------------------------------

/**
 * Parses the ProseMirror document using the schema from the `AnnAdmin` app and returns
 * a DOM tree of the HTML that the document represents.
 */
function parse(doc) {
  const parsed = JSON.parse(doc)
  const node = schema.nodeFromJSON(parsed)

  return DOMSerializer.fromSchema(schema).serializeFragment(node.content, {
    document: window.document,
  })
}
