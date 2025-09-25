return {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = 'standard', -- Use 'standard' like pyright instead of the default 'recommended'.
        diagnosticMode = 'workspace', -- "openFilesOnly" (default), "workspace" (slower)
      },
    },
  },
}
