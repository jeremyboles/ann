import { Schema } from "prosemirror-model"
import { schema } from "prosemirror-schema-basic"
import { addListNodes } from "prosemirror-schema-list"

//
// Schema definition
// -------------------------------------------------------------------------------------------------

// Require the the document starts with a heading
schema.topNodeType.spec.content = "heading+ block+"

export default new Schema({
  marks: schema.spec.marks,
  nodes: addListNodes(schema.spec.nodes, "paragraph block*", "block"),
})
