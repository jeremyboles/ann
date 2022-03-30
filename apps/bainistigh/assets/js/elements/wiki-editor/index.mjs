import { baseKeymap } from 'prosemirror-commands'
import { schema } from 'prosemirror-schema-basic'
import { undo, redo, history } from 'prosemirror-history'
import { keymap } from 'prosemirror-keymap'
import { EditorState } from 'prosemirror-state'
import { EditorView } from 'prosemirror-view'

//
// Custom element implementation
//
// Docs on how to implement the API for a form control:
// https://web.dev/more-capable-form-controls/
// -------------------------------------------------------------------------------------------------

export class WikiEditor extends HTMLElement {
  static stylesheet = '/assets/elements/wiki-editor.css'

  constructor() {
    super()

    // Open up the shadow root so we can start adding element to it
    this.attachShadow({ mode: 'open' })

    // Import the stylesheet for the editor itself
    const link = document.createElement('link')
    link.setAttribute('href', this.constructor.stylesheet)
    link.setAttribute('rel', 'stylesheet')
    this.shadowRoot.append(link)
  }

  connectedCallback() {
    const state = EditorState.create({
      plugins: [
        history(),
        keymap({ 'Mod-z': undo, 'Mod-y': redo }),
        keymap(baseKeymap),
      ],
      schema,
    })
    this.view = new EditorView(this.shadowRoot, { state })
    this.view.focus()

    this.addEventListener('click', console.info)
  }
}

customElements?.define('wiki-editor', WikiEditor)
