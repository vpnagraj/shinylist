#' HTML lists with R
#'
#' Create an HTML list from R input. Vector input will be parsed by element and output as either ordered or unordered list item(s). Can be used inside of Shiny app with \code{\link{listOuput}} and \code{\link{renderList}}.
#'
#' @param dat the vector of data to be output as HTML list
#' @param oderered indicator of whether or not list should be ordered (i.e. numbered) or unordered
#' @export
shinylist <- function(dat, ordered = FALSE, width = NULL, height = NULL) {

    if (!is.vector(dat))
        stop("data must be a vector")

    dat

    if(ordered){
        ordered = "ol"
    } else {
        ordered = "ul"
    }
    x <- list(
        dat = dat,
        ordered = ordered
    )

    # create widget
    htmlwidgets::createWidget(
        name = 'shinylist',
        x,
        width = width,
        height = height,
        package = 'shinylist'
    )
}

#' @name listOutput for Shiny
#'
#' @export
listOutput <- function(outputId, width = '100%', height = '400px'){
    htmlwidgets::shinyWidgetOutput(outputId, 'shinylist', width, height, package = 'shinylist')
}

#' @name renderList for Shiny
#'
#' @export
renderList <- function(expr, env = parent.frame(), quoted = FALSE) {
    if (!quoted) { expr <- substitute(expr) } # force quoted
    htmlwidgets::shinyRenderWidget(expr, listOutput, env, quoted = TRUE)
}