import { baseKeymap, toggleMark } from "prosemirror-commands"
import { history, redo, undo } from "prosemirror-history"
import { inputRules, wrappingInputRule } from "prosemirror-inputrules"
import { keymap } from "prosemirror-keymap"
import { Fragment, Slice } from "prosemirror-model"
import { Plugin } from "prosemirror-state"
import { canSplit, findWrapping, ReplaceAroundStep } from "prosemirror-transform"
import { Decoration, DecorationSet } from "prosemirror-view"

import schema from "./schema.mjs"

const plugins = [
  history(),

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

  keymap({ "Mod-z": undo, "Mod-Shift-z": redo }),

  keymap({
    "Mod-b": toggleMark(schema.marks.strong),
    "Mod-i": toggleMark(schema.marks.em),
  }),

  keymap({
    "Mod-Alt-8": wrapInList(schema.nodes.bullet_list),
    "Mod-Alt-9": wrapInList(schema.nodes.ordered_list),
    Enter: splitListItem,
  }),

  keymap(baseKeymap),

  placeholders(),
]

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

function splitListItem(state, dispatch) {
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
