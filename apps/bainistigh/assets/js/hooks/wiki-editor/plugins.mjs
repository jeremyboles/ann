import { baseKeymap, toggleMark } from "prosemirror-commands"
import { history, redo, undo } from "prosemirror-history"
import { ellipsis, emDash, inputRules, smartQuotes, wrappingInputRule } from "prosemirror-inputrules"
import { keymap } from "prosemirror-keymap"
import { Fragment, Slice } from "prosemirror-model"
import { Plugin } from "prosemirror-state"
import { canSplit, findWrapping, ReplaceAroundStep } from "prosemirror-transform"
import { Decoration, DecorationSet } from "prosemirror-view"

export default function plugins(schema) {
  return [
    history(),

    // Markdown-esque shortcuts for lists
    inputRules({
      rules: [
        wrappingInputRule(/^\s*([-+*])\s$/, schema.nodes.bullet_list),
        wrappingInputRule(
          /^(\d+)\.\s$/,
          schema.nodes.ordered_list,
          (match) => ({ order: +match[1] }),
          (match, node) => node.childCount + node.attrs.order == +match[1]
        ),
      ],
    }),

    // Smartypants-esque shortcuts for nice typography
    inputRules({
      rules: [...smartQuotes, ellipsis, emDash],
    }),

    // Keyboard shortcuts for undo/redo
    keymap({ "Mod-z": undo, "Mod-Shift-z": redo }),

    // Keyboard shortcuts for bold/italic
    keymap({
      "Mod-b": toggleMark(schema.marks.strong),
      "Mod-i": toggleMark(schema.marks.em),
    }),

    // Keyboard shortcuts for creating lists
    keymap({
      "Mod-Alt-8": wrapInList(schema.nodes.bullet_list),
      "Mod-Alt-9": wrapInList(schema.nodes.ordered_list),
      Enter: splitListItem,
    }),

    keymap(baseKeymap),

    placeholders(),
    tooltips(),
  ]
}

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

function tooltips() {
  const plugin = new Plugin({
    view(editorView) {
      return new SelectionSizeTooltip(editorView)
    },
  })
  return plugin
}

//
// Private classes
// -----------------------------------------------------------------------------------------------

class SelectionSizeTooltip {
  constructor(view) {
    const { schema } = view.state
    this.tooltip = document.createElement("div")
    this.tooltip.className = "tooltip"

    this.boldButton = document.createElement("button")
    this.boldButton.addEventListener("pointerdown", (event) => {
      event.preventDefault()
      toggleMark(schema.marks.strong)(view.state, view.dispatch)
    })
    this.boldButton.className = "bold"
    this.boldButton.setAttribute("type", "button")
    this.boldButton.textContent = "Bold"
    this.tooltip.appendChild(this.boldButton)

    this.italicButton = document.createElement("button")
    this.italicButton.addEventListener("pointerdown", (event) => {
      event.preventDefault()
      toggleMark(schema.marks.em)(view.state, view.dispatch)
    })
    this.italicButton.className = "italic"
    this.italicButton.setAttribute("type", "button")
    this.italicButton.textContent = "Italic"
    this.tooltip.appendChild(this.italicButton)

    this.linkButton = document.createElement("button")
    this.linkButton.addEventListener("pointerdown", (event) => {
      event.preventDefault()
      this.linkInput.style.display = "unset"
      this.linkInput.focus()
    })
    this.linkButton.className = "link"
    this.linkButton.setAttribute("type", "button")
    this.linkButton.textContent = "Link"
    this.tooltip.appendChild(this.linkButton)

    this.linkInput = document.createElement("input")
    this.linkInput.addEventListener("blur", () => {
      this.linkInput.style.display = "none"
      this.linkInput.value = ""
    })
    this.linkInput.addEventListener("focus", () => {})
    this.linkInput.addEventListener("keydown", (event) => {
      event.stopPropagation()

      if (event.key === "Escape") {
        this.linkInput.blur()
      } else if (event.key === "Enter") {
        if (this.linkInput.checkValidity()) {
          toggleMark(schema.marks.link, { href: this.linkInput.value })(view.state, view.dispatch)
          this.linkInput.blur()
          this.tooltip.style.display = "none"
        }
      }
    })
    this.linkInput.setAttribute("autocomplete", "off")
    this.linkInput.setAttribute("form", "none")
    this.linkInput.setAttribute("placeholder", "Paste or type a link…")
    this.linkInput.setAttribute("required", true)
    this.linkInput.setAttribute("type", "text")
    this.tooltip.appendChild(this.linkInput)

    view.dom.parentNode.appendChild(this.tooltip)
    this.update(view, null)
  }

  update(view, lastState) {
    const state = view.state
    const { schema } = view.state
    // Don't do anything if the document/selection didn't change
    if (lastState && lastState.doc.eq(state.doc) && lastState.selection.eq(state.selection)) return

    // Hide the tooltip if the selection is empty
    if (state.selection.empty) {
      this.tooltip.style.display = "none"
      return
    }

    // Otherwise, reposition it and update its content
    this.tooltip.style.display = ""

    const { from, to } = state.selection

    // These are in screen coordinates
    const start = view.coordsAtPos(from)
    const end = view.coordsAtPos(to)
    // The box in which the tooltip is positioned, to use as base
    const box = this.tooltip.offsetParent.getBoundingClientRect()

    // Find a center-ish x position from the selection endpoints (when
    // crossing lines, end may be more to the left)
    const left = Math.max((start.left + end.left) / 2, start.left + 3)
    this.tooltip.style.left = left - box.left + "px"
    this.tooltip.style.bottom = box.bottom - start.top + "px"
  }

  destroy() {
    this.tooltip.remove()
  }
}

//
// Private functions
// -------------------------------------------------------------------------------------------------

function isEmptyHeading(node) {
  return node.type.name === "heading" && node.isTextblock && node.content.size == 0
}

function isEmptyParagraph(node) {
  return node.type.name === "paragraph" && node.isTextblock && node.content.size == 0
}

function splitListItem(state, dispatch) {
  const { schema } = state
  const { $from, $to, node } = state.selection
  if ((node && node.isBlock) || $from.depth < 2 || !$from.sameParent($to)) return false

  const grandParent = $from.node(-1)
  if (grandParent.type != schema.nodes.list_item) return false

  if ($from.parent.content.size == 0 && $from.node(-1).childCount == $from.indexAfter(-1)) {
    // In an empty block. If this is a nested list, the wrapping
    // list item should be split. Otherwise, bail out and let next
    // command handle lifting.
    if ($from.depth == 3 || $from.node(-3).type != schema.nodes.list_item || $from.index(-2) != $from.node(-2).childCount - 1) return false

    if (dispatch) {
      let wrap = Fragment.empty
      const depthBefore = $from.index(-1) ? 1 : $from.index(-2) ? 2 : 3

      // Build a fragment containing empty versions of the structure
      // from the outer list item to the parent node of the cursor
      for (let d = $from.depth - depthBefore; d >= $from.depth - 3; d--) wrap = Fragment.from($from.node(d).copy(wrap))
      const depthAfter = $from.indexAfter(-1) < $from.node(-2).childCount ? 1 : $from.indexAfter(-2) < $from.node(-3).childCount ? 2 : 3

      // Add a second list item with an empty default start node
      wrap = wrap.append(Fragment.from(schema.nodes.list_item.createAndFill()))
      const start = $from.before($from.depth - (depthBefore - 1))
      const tr = state.tr.replace(start, $from.after(-depthAfter), new Slice(wrap, 4 - depthBefore, 0))
      let sel = -1
      tr.doc.nodesBetween(start, tr.doc.content.size, (node, pos) => {
        if (sel > -1) return false
        if (node.isTextblock && node.content.size == 0) sel = pos + 1
      })
      if (sel > -1) tr.setSelection(Selection.near(tr.doc.resolve(sel)))
      dispatch(tr.scrollIntoView())
    }
    return true
  }

  const nextType = $to.pos == $from.end() ? grandParent.contentMatchAt(0).defaultType : null
  const tr = state.tr.delete($from.pos, $to.pos)
  const types = nextType ? [null, { type: nextType }] : undefined

  if (!canSplit(tr.doc, $from.pos, 2, types)) return false
  if (dispatch) dispatch(tr.split($from.pos, 2, types).scrollIntoView())
  return true
}

function wrapInList(type, attrs) {
  return function (state, dispatch) {
    const { $from, $to } = state.selection

    let doJoin = false

    let range = $from.blockRange($to)
    let outerRange = range

    if (!range) return false

    // This is at the top of an existing list item
    if (range.depth >= 2 && $from.node(range.depth - 1).type.compatibleContent(type) && range.startIndex == 0) {
      // Don't do anything if this is the top of the list
      if ($from.index(range.depth - 1) == 0) return false
      const $insert = state.doc.resolve(range.start - 2)
      outerRange = new NodeRange($insert, $insert, range.depth)
      if (range.endIndex < range.parent.childCount) range = new NodeRange($from, state.doc.resolve($to.end(range.depth)), range.depth)
      doJoin = true
    }

    const wrap = findWrapping(outerRange, type, attrs, range)
    if (!wrap) return false

    if (dispatch) dispatch(wrapInListDispatcher(state.tr, range, wrap, doJoin, type).scrollIntoView())
    return true
  }
}

function wrapInListDispatcher(tr, range, wrappers, joinBefore, type) {
  let content = Fragment.empty

  for (let i = wrappers.length - 1; i >= 0; i--) content = Fragment.from(wrappers[i].type.create(wrappers[i].attrs, content))
  tr.step(new ReplaceAroundStep(range.start - (joinBefore ? 2 : 0), range.end, range.start, range.end, new Slice(content, 0, 0), wrappers.length, true))

  let found = 0
  for (let i = 0; i < wrappers.length; i++) if (wrappers[i].type == type) found = i + 1
  let splitDepth = wrappers.length - found

  let splitPos = range.start + wrappers.length - (joinBefore ? 2 : 0)
  let parent = range.parent

  for (let i = range.startIndex, e = range.endIndex, first = true; i < e; i++, first = false) {
    if (!first && canSplit(tr.doc, splitPos, splitDepth)) {
      tr.split(splitPos, splitDepth)
      splitPos += 2 * splitDepth
    }
    splitPos += parent.child(i).nodeSize
  }

  return tr
}
