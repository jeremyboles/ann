import { EditorState } from 'prosemirror-state'
import { EditorView } from 'prosemirror-view'

import plugins from './plugins.mjs'
import schema from './schema.mjs'

//
// Settings & constants
// -----------------------------------------------------------------------------------------------

const DEFAULT_CONTENT = [
  { type: 'heading', attrs: { level: 1 } },
  { type: 'paragraph' },
]

//
// Exported functions
// -----------------------------------------------------------------------------------------------

export function destroyed() {
  this.view?.destroy()
}

export function mounted() {
  const content = document.getElementById(this.el.dataset.input)?.value
    ? JSON.parse(document.getElementById(this.el.dataset.input)?.value)
    : DEFAULT_CONTENT

  const doc = schema.nodeFromJSON({ content, type: 'doc' })
  const state = EditorState.create({ doc, plugins, schema })

  this.view = new EditorView(this.el, {
    dispatchTransaction: dispatchTransaction.bind(this),
    state,
  })

  this.view.focus()
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
