import { exampleSetup } from "prosemirror-example-setup"

import { Plugin } from "prosemirror-state"
import { Decoration, DecorationSet } from "prosemirror-view"

import schema from "./schema.mjs"

const plugins = [...exampleSetup({ menuBar: false, schema }), placeholders()]

export default plugins

//
// Private plugins
// -------------------------------------------------------------------------------------------------

/**
 * Adds the attribute `data-placeholder` to any instance of the given `type` that. This can then be
 * used within CSS to display placeholder text.

 */
function placeholders() {
  const plugin = new Plugin({
    props: {
      decorations({ doc }) {
        const decorations = []

        if (isEmptyHeading(doc.firstChild)) {
          decorations.push(Decoration.node(0, 2, { "data-placeholder": "Wiki Article Title" }))
        }

        if (doc.childCount === 2 && isEmptyParagraph(doc.lastChild)) {
          const offset = doc.firstChild.nodeSize
          decorations.push(
            Decoration.node(offset, offset + 2, {
              "data-placeholder": "Type something…",
            })
          )
        }

        return DecorationSet.create(doc, decorations)
      },
    },
  })
  return plugin
}

//
// Private function
// -------------------------------------------------------------------------------------------------

function isEmptyHeading(node) {
  return node.type.name === "heading" && node.isTextblock && node.content.size == 0
}

function isEmptyParagraph(node) {
  return node.type.name === "paragraph" && node.isTextblock && node.content.size == 0
}
