module.exports = () => ({
  plugins: [
    // require("postcss-preset-env")({ browsers: ["last 1 version"] }),
    require("postcss-csso")({ forceMediaMerge: true }),
  ],
})
