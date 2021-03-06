\name{plot.enve.RecPlot2}
\alias{plot.enve.RecPlot2}
\title{plot enve RecPlot2}
\description{Plots an `enve.RecPlot2` object.}
\usage{\method{plot}{enve.RecPlot2}(x, layout = matrix(c(5, 5, 2, 1, 4, 3), nrow = 2), 
    panel.fun = list(), widths = c(1, 7, 2), heights = c(1, 2), 
    palette = grey((100:0)/100), underlay.group = TRUE, peaks.col = "darkred", 
    use.peaks, id.lim = range(x$id.breaks), pos.lim = range(x$pos.breaks), 
    pos.units = c("Mbp", "Kbp", "bp"), mar = list(`1` = c(5, 
        4, 1, 1) + 0.1, `2` = c(ifelse(any(layout == 1), 1, 5), 
        4, 4, 1) + 0.1, `3` = c(5, ifelse(any(layout == 1), 1, 
        4), 1, 2) + 0.1, `4` = c(ifelse(any(layout == 1), 1, 
        5), ifelse(any(layout == 2), 1, 4), 4, 2) + 0.1, `5` = c(5, 
        3, 4, 1) + 0.1, `6` = c(5, 4, 4, 2) + 0.1), pos.splines = 0, 
    id.splines = 1/2, in.lwd = ifelse(is.null(pos.splines) || 
        pos.splines > 0, 1/2, 2), out.lwd = ifelse(is.null(pos.splines) || 
        pos.splines > 0, 1/2, 2), id.lwd = ifelse(is.null(id.splines) || 
        id.splines > 0, 1/2, 2), in.col = "darkblue", out.col = "lightblue", 
    id.col = "black", breaks.col = "#AAAAAA40", peaks.opts = list(), 
    ...)}
\arguments{
  \item{x}{`enve.RecPlot2` object to plot.}
  \item{layout}{Matrix indicating the position of the different panels in the layout,
where:
0: Empty space,
1: Counts matrix,
2: position histogram (sequencing depth),
3: identity histogram,
4: Populations histogram (histogram of sequencing depths),
5: Color scale for the counts matrix (vertical),
6: Color scale of the counts matrix (horizontal)
Only panels indicated here will be plotted. To plot only one panel
simply set this to the number of the panel you want to plot.}
  \item{panel.fun}{List of functions to be executed after drawing each panel. Use the
indices in `layout` (as characters) as keys. Functions for indices
missing in `layout` are ignored. For example, to add a vertical line
at the 3Mbp mark in both the position histogram and the counts matrix:
`list('1'=function() abline(v=3), '2'=function() abline(v=3))`.
Note that the X-axis in both panels is in Mbp by default. To change
this behavior, set `pos.units` accordingly.}
  \item{widths}{Relative widths of the columns of `layout`.}
  \item{heights}{Relative heights of the rows of `layout`.}
  \item{palette}{Colors to be used to represent the counts matrix, sorted from no hits
to the maximum sequencing depth.}
  \item{underlay.group}{If TRUE, it indicates the in-group and out-group areas couloured based
on `in.col` and `out.col`. Requires support for semi-transparency.}
  \item{peaks.col}{If not NA, it attempts to represent peaks in the population histogram
in the specified color. Set to NA to avoid peak-finding.}
  \item{use.peaks}{A list of `enve.RecPlot2.Peak` objects, as returned by
`enve.recplot2.findPeaks`. If passed, `peaks.opts` is ignored.}
  \item{id.lim}{Limits of identities to represent.}
  \item{pos.lim}{Limits of positions to represent (in bp, regardless of `pos.units`).}
  \item{pos.units}{Units in which the positions should be represented (powers of 1,000
base pairs).}
  \item{mar}{
}
  \item{pos.splines}{Smoothing parameter for the splines in the position histogram. Zero
(0) for no splines. Use NULL to automatically detect by leave-one-out
cross-validation.}
  \item{id.splines}{Smoothing parameter for the splines in the identity histogram. Zero
(0) for no splines. Use NULL to automatically detect by leave-one-out
cross-validation.}
  \item{in.lwd}{Line width for the sequencing depth of in-group matches.}
  \item{out.lwd}{Line width for the sequencing depth of out-group matches.}
  \item{id.lwd}{Line width for the identity histogram.}
  \item{in.col}{Color associated to in-group matches.}
  \item{out.col}{Color associated to out-group matches.}
  \item{id.col}{Color for the identity histogram.}
  \item{breaks.col}{Color of the vertical lines indicating sequence breaks.}
  \item{peaks.opts}{Options passed to `enve.recplot2.findPeaks`, if `peaks.col` is not NA.}
  \item{\dots}{Any other graphic parameters (currently ignored).}
}

\value{Returns a list of `enve.RecPlot2.Peak` objects (see
`enve.recplot2.findPeaks`). If `peaks.col`=NA or `layout` doesn't include
4, returns NA.}

\author{Luis M. Rodriguez-R [aut, cre]}





