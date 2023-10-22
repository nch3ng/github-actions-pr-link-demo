const path = require("path");
const ForkTsCheckerWebpackPlugin = require("fork-ts-checker-webpack-plugin");

const all = [
  {
    entry: "./src/lambdas/originRequest",
    filename: "origin-request/index.js"
  },
  {
    entry: "./src/lambdas/viewerRequest",
    filename: "viewer-request/index.js"
  }
];

module.exports = all.map((item) => ({
  mode: "production",
  entry: item.entry,
  resolve: {
    extensions: [".js", ".jsx", ".json", ".ts", ".tsx"]
  },
  output: {
    libraryTarget: "commonjs",
    path: path.join(__dirname, ".dist"),
    filename: item.filename
  },
  optimization: {
    minimize: false
  },
  cache: true,
  target: "node",
  module: {
    rules: [
      // all files with a `.ts`, `.cts`, `.mts` or `.tsx` extension will be handled by `ts-loader`
      { test: /\.([cm]?ts|tsx)$/, loader: "ts-loader" },
      { loader: "source-map-loader", test: /\.ts$/ }
    ]
  },
  plugins: [
    new ForkTsCheckerWebpackPlugin({
      typescript: {
        diagnosticOptions: {
          semantic: true,
          syntactic: true
        }
      }
    })
  ],
  externals: {
    "aws-sdk": "aws-sdk"
  }
}));
