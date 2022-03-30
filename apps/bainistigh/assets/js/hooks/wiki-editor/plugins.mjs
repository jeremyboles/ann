import { baseKeymap } from 'prosemirror-commands'
import { history, redo, undo } from 'prosemirror-history'
import { keymap } from 'prosemirror-keymap'

const plugins = [
  history(),
  keymap(baseKeymap),
  keymap({ 'Mod-z': undo, 'Mod-Shift-z': redo }),
]

export default plugins
