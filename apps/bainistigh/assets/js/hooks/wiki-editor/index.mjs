import { EditorState } from "prosemirror-state"
import { EditorView } from "prosemirror-view"

import plugins from "./plugins.mjs"
import schema from "./schema.mjs"

//
// Settings & constants
// -----------------------------------------------------------------------------------------------

const DEFAULT_JSON = { content: [{ type: "heading", attrs: { level: 1 } }, { type: "paragraph" }], type: "doc" }

//
// Exported functions
// -----------------------------------------------------------------------------------------------

export function beforeUpdate() {
  this.view?.destroy()
}

export function destroyed() {
  this.view?.destroy()
}

export function mounted() {
  const json = document.getElementById(this.el.dataset.input)?.value ? JSON.parse(document.getElementById(this.el.dataset.input)?.value) : DEFAULT_JSON

  const doc = schema.nodeFromJSON(json)
  const state = EditorState.create({ doc, plugins, schema })

  this.view = new EditorView(this.el, {
    dispatchTransaction: dispatchTransaction.bind(this),
    state,
  })

  this.view.focus()
}

export function updated() {
  const json = document.getElementById(this.el.dataset.input)?.value ? JSON.parse(document.getElementById(this.el.dataset.input)?.value) : DEFAULT_JSON

  const doc = schema.nodeFromJSON(json)
  const state = EditorState.create({ doc, plugins, schema })

  this.view = new EditorView(this.el, {
    dispatchTransaction: dispatchTransaction.bind(this),
    state,
  })
}

//
// Private functions
// -----------------------------------------------------------------------------------------------

function dispatchTransaction(transaction) {
  const state = this.view.state.apply(transaction)
  this.view.updateState(state)

  const json = JSON.stringify(state.doc.toJSON())
  document.getElementById(this.el.dataset.input).value = json
}
