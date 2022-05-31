import { Schema } from "prosemirror-model"

//
// Schema definition
// -------------------------------------------------------------------------------------------------

const schema = new Schema({
  marks: {
    em: {
      parseDOM: [{ tag: "em" }, { tag: "i" }, { style: "font-style=italic" }],
      toDOM() {
        return ["em", 0]
      },
    },
    strong: {
      parseDOM: [{ tag: "b" }, { tag: "string" }, { style: "font-style=bold" }],
      toDOM() {
        return ["strong", 0]
      },
    },
  },

  nodes: {
    //
    // Basic node types
    // -----------------------------------------------------------------------------------------------
    doc: { content: "heading+ block+" },

    paragraph: {
      content: "inline*",
      group: "block",
      parseDOM: [{ tag: "p" }],
      toDOM() {
        return ["p", 0]
      },
    },

    heading: {
      attrs: { level: { default: 1 } },
      content: "inline*",
      defining: true,
      group: "block",
      parseDOM: [
        { tag: "h1", attrs: { level: 1 } },
        { tag: "h2", attrs: { level: 2 } },
      ],
      toDOM(node) {
        return [`h${node.attrs.level}`, 0]
      },
    },

    ordered_list: {
      attrs: { order: { default: 1 } },
      content: "list_item+",
      group: "block",
      parseDOM: [
        {
          tag: "ol",
          getAttrs(dom) {
            return { order: dom.hasAttribute("start") ? +dom.getAttribute("start") : 1 }
          },
        },
      ],
      toDOM(node) {
        return node.attrs.order == 1 ? ["ol", 0] : ["ol", { start: node.attrs.order }, 0]
      },
    },
    bullet_list: {
      parseDOM: [{ tag: "ul" }],
      content: "list_item+",
      group: "block",
      toDOM() {
        return ["ul", 0]
      },
    },
    list_item: {
      content: "paragraph block*",
      defining: true,
      parseDOM: [{ tag: "li" }],
      toDOM() {
        return ["li", 0]
      },
    },

    text: { group: "inline" },
  },
})

export default schema
