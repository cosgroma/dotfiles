MathJax.Hub.Config({
  config: ["MMLorHTML.js"],
  extensions: ["tex2jax.js"],
  jax: ["input/TeX"],
  tex2jax: {
    inlineMath: [
      ['$', '$'],
      ["\\(", "\\)"]
    ],
    displayMath: [
      ['$$', '$$'],
      ["\\[", "\\]"]
    ],
    processEscapes: false
  },
  TeX: {
    extensions: ["AMSmath.js", "AMSsymbols.js"],
    TagSide: "right",
    TagIndent: ".8em",
    MultLineWidth: "85%",
    equationNumbers: {
      autoNumber: "AMS",
    },
    unicode: {
      fonts: "STIXGeneral,'Arial Unicode MS'"
    }
  },
  showProcessingMessages: false
});
