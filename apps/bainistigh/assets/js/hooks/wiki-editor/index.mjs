import { EditorState } from 'prosemirror-state'
import { EditorView } from 'prosemirror-view'

import plugins from './plugins.mjs'
import schema from './schema.mjs'

//
// Exported functions
// -----------------------------------------------------------------------------------------------

export function beforeUpdate() {
  console.log('[wiki-editor BEFORE UPDATE]')
}

export function destroyed() {
  console.log('[wiki-editor DESTROYED]')
}

export function disconnected() {
  console.log('[wiki-editor DISCONNECTED]')
}

export function mounted() {
  console.log('[wiki-editor MOUNTED]')

  const doc = schema.nodeFromJSON({
    content: [{ type: 'heading', attrs: { level: 1 } }, { type: 'paragraph' }],
    type: 'doc',
  })

  const state = EditorState.create({ doc, plugins, schema })
  const view = new EditorView(this.el, { state })

  view.focus()
}

export function reconnected() {
  console.log('[wiki-editor RECONNNECTED]')
}

export function updated() {
  console.log('[wiki-editor UPDATED]')
}
