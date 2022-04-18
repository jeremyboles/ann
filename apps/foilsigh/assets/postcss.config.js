module.exports = () => ({
  plugins: [
    require("postcss-preset-env")({
      features: {
        "custom-properties": false,
      },
      stage: 3,
    }),
    require("postcss-csso")({ forceMediaMerge: true }),
  ],
})
