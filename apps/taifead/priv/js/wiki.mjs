import jsdom from 'jsdom'
import { DOMSerializer } from 'prosemirror-model'

import schema from 'bainistighn/wiki-schema'

//
// Exported functions
// -------------------------------------------------------------------------------------------------

export default function extract(doc) {
  // Create a virtual DOM environment, using JSDOM and then have ProseMirror serialize the document
  // and return a virtual `DocumentFragment` object.
  const { window } = new jsdom.JSDOM()
  const node = schema.nodeFromJSON(doc)
  const dom = DOMSerializer.fromSchema(schema).serializeFragment(node.content, {
    document: window.document,
  })

  // Pull the title out of the parsed document
  const $title = dom.firstChild

  // Extract everything _after_ the title element and add it to a virtual div element.
  const template = window.document.createElement('div')
  for (let i = 1; i < dom.childNodes.length; i++) {
    const child = dom.childNodes[i].cloneNode(true)
    if (child) template.appendChild(child)
    if (i < dom.childNodes.length - 1) template.appendChild(window.document.createTextNode(' '))
  }

  return {
    content_html: template.innerHTML,
    content_text: template.textContent,

    title_html: $title.innerHTML,
    title_text: $title.textContent,
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
