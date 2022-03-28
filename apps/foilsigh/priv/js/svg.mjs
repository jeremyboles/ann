import { optimize } from 'svgo'

//
// Main script
// -------------------------------------------------------------------------------------------------

export function minify(path, svg) {
  const { data } = optimize(svg, {
    multipass: true,
    path,
    plugins: [
      { name: 'preset-default', params: { overrides: { cleanupIDs: false } } },
    ],
  })

  return data
}
