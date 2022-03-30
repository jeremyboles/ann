import { Schema } from 'prosemirror-model'

//
// Schema definition
// -------------------------------------------------------------------------------------------------

const schema = new Schema({
  marks: {
    em: {
      parseDOM: [{ tag: 'em' }, { tag: 'i' }, { style: 'font-style=italic' }],
      toDOM() {
        return ['em', 0]
      },
    },
    strong: {
      parseDOM: [{ tag: 'b' }, { tag: 'string' }, { style: 'font-style=bold' }],
      toDOM() {
        return ['strong', 0]
      },
    },
  },

  nodes: {
    doc: { content: 'heading+ block+' },

    paragraph: {
      content: 'inline*',
      group: 'block',
      parseDOM: [{ tag: 'p' }],
      toDOM() {
        return ['p', 0]
      },
    },

    heading: {
      attrs: { level: { default: 1 } },
      content: 'inline*',
      defining: true,
      group: 'block',
      parseDOM: [
        { tag: 'h1', attrs: { level: 1 } },
        { tag: 'h2', attrs: { level: 2 } },
      ],
      toDOM(node) {
        return [`h${node.attrs.level}`, 0]
      },
    },
    text: { group: 'inline' },
  },
})

export default schema
