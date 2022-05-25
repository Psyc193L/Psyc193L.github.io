"%||%" <- function(a, b) {
  if (!is.null(a)) a else b
}

geom_flat_violin <- function(mapping = NULL, data = NULL, stat = "ydensity",
                             position = "dodge", trim = TRUE, scale = "area",
                             show.legend = NA, inherit.aes = TRUE, ...) {
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomFlatViolin,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      trim = trim,
      scale = scale,
      ...
    )
  )
}

# @rdname ggplot2-ggproto
# @format NULL
# @usage NULL
# @export
GeomFlatViolin <-
  ggproto("GeomFlatViolin", Geom,
          setup_data = function(data, params) {
            data$width <- data$width %||%
              params$width %||% (resolution(data$x, FALSE) * 0.9)
            
            # ymin, ymax, xmin, and xmax define the bounding rectangle for each group
            data %>%
              group_by(group) %>%
              mutate(ymin = min(y),
                     ymax = max(y),
                     xmin = x,
                     xmax = x + width / 2)
          },
          
          draw_group = function(data, panel_scales, coord) {
            # Find the points for the line to go all the way around
            data <- transform(data, xminv = x,
                              xmaxv = x + violinwidth * (xmax - x))
            
            # Make sure it's sorted properly to draw the outline
            newdata <- rbind(plyr::arrange(transform(data, x = xminv), y),
                             plyr::arrange(transform(data, x = xmaxv), -y))
            
            # Close the polygon: set first and last point the same
            # Needed for coord_polar and such
            newdata <- rbind(newdata, newdata[1,])
            
            ggplot2:::ggname("geom_flat_violin", GeomPolygon$draw_panel(newdata, panel_scales, coord))
          },
          
          draw_key = draw_key_polygon,
          
          default_aes = aes(weight = 1, colour = "grey20", fill = "white", size = 0.5,
                            alpha = NA, linetype = "solid"),
          
          required_aes = c("x", "y")
  )

# Example

# rain_height <- .1
# 
# penguins %>%
#   ggplot(aes(x = "", y = body_mass_g, fill = species)) +
#   # clouds  
#   geom_flat_violin(position = position_nudge(x = rain_height+.05),
#                    alpha = 0.4, trim = FALSE) + 
#   # rain
#   geom_point(aes(colour = species), size = 2, alpha = .5, show.legend = FALSE, 
#              position = position_jitter(width = 0.05, height = 0)) +
#   # boxplots
#   geom_boxplot(width = 0.05, alpha = 0.4, show.legend = FALSE, 
#                outlier.shape = NA,
#                position = position_nudge(x = -rain_height*2)) +
#   # mean and SE point in the cloud
#   stat_summary(fun.data = mean_cl_normal, mapping = aes(color = species), show.legend = FALSE,
#                position = position_nudge(x = rain_height * 3)) +
#   # adjust layout
#   scale_x_discrete(name = "", expand = c(rain_height*3, 0, 0, 0.7)) +
#   scale_y_continuous(limits = c(2000, 7000)) +
#   coord_flip() +
#   facet_grid(rows = vars(island))+
#   theme_minimal()